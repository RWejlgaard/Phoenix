provider "google" {
  project     = "rwejlgaard"
  region      = "europe-west2"
  credentials = var.gcloud-credential
}

terraform {
  backend "remote" {
    organization = "rwejlgaard"

    workspaces {
      name = "phoenix"
    }
  }
}
