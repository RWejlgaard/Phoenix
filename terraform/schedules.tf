//resource "google_cloud_scheduler_job" "job" {
//  name             = "gp-weather"
//  description      = "general purpose weather"
//  schedule         = "*/15 * * * *"
//  time_zone        = "Europe/London"
//  attempt_deadline = "320s"
//
//  retry_config {
//    retry_count = 1
//  }
//
//  http_target {
//    http_method = "POST"
//    uri         = "https://europe-west2-rwejlgaard.cloudfunctions.net/general-purpose"
//    body        = base64encode("{\"function\": [\"weather\"]}")
//  }
//}