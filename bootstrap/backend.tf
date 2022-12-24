terraform {
  backend "gcs" {
    bucket = "sand-shr-terraform-state"
    prefix = "bootstrap"
  }
}
