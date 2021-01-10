provider "google" {
  project     = "rwejlgaard"
  region      = "europe-west2"

}

terraform {
  backend "remote" {
    organization = "rwejlgaard"

    workspaces {
      name = "phoenix"
    }
  }
}
