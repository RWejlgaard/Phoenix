resource "google_storage_bucket" "bucket" {
  name = "staging-rwejlgaard"
}


resource "google_storage_bucket_object" "archive" {
  for_each = fileset("${path.module}/files", "*.zip")
  name   = "${timestamp()}-${each.value}"
  bucket = google_storage_bucket.bucket.name
  source = "${path.module}/files/${each.key}"
}

resource "google_cloudfunctions_function" "function" {
  for_each = fileset("${path.module}/files", "*.zip")
  name        = split(".zip", each.key)[0]
  description = "managed by terraform"
  runtime     = "python38"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive[each.key].name
  trigger_http          = true
  timeout               = 60
  entry_point           = "main"

  labels = {
    my-label = "my-label-value"
  }

  environment_variables = {
    openweathermap-api-key = var.openweathermap-api-key
  }
}

# IAM entry for a single user to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  for_each = fileset("${path.module}/files", "*.zip")
  project        = google_cloudfunctions_function.function[each.key].project
  region         = google_cloudfunctions_function.function[each.key].region
  cloud_function = google_cloudfunctions_function.function[each.key].name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}