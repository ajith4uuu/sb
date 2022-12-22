terraform {
  backend "gcs" {
    bucket = "sdbx-shr-terraform-state"
    prefix = "bootstrap"
  }
}
