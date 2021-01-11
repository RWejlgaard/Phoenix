
resource "google_storage_bucket_object" "archive" {
  name   = "${timestamp()}-${var.function_name}"
  bucket = var.staging_bucket_name
  source = "${path.root}/files/${var.function_name}.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = var.function_name
  description = "managed by terraform"
  runtime     = "python38"

  available_memory_mb   = 128
  source_archive_bucket = var.staging_bucket_name
  source_archive_object = google_storage_bucket_object.archive.name
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
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}