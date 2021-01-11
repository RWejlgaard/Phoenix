resource "google_storage_bucket" "bucket" {
  name = "phoenix-rwejlgaard-staging"
}

module "lambda-function" {
  for_each = fileset("${path.module}/files", "*.zip")
  source = "./modules/lambda-function"
  function_name = split(".zip", each.key)[0]
  staging_bucket_name = google_storage_bucket.bucket.name
  openweathermap-api-key = var.openweathermap-api-key
}