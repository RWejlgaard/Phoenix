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

resource "google_endpoints_service" "openapi_service" {
  service_name   = "phoenix.apigateway.rwejlgaard.cloud.goog"
  openapi_config = file("./files/phoenix-api.yaml")
}