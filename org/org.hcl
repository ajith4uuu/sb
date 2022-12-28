# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Configure Terragrunt to automatically store tfstate files: https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/#create-remote-state-and-locking-resources-automatically
remote_state {
  backend = "gcs"
  # Same state bucket for for all envs - resources are created in bootstrap folder
  config = {
    bucket = "sb-shr-terraform-state"
    prefix = "org/${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

# Generate the GCP provider block - resources are created in bootstrap folder
generate "gcp-provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "google" {
  alias = "impersonate"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google.impersonate
  target_service_account = "sb-shr-terraform@sand-shr-terraform-178c.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "600s"
}

provider "google" {
  access_token = data.google_service_account_access_token.default.access_token
}

provider "google-beta" {
  access_token = data.google_service_account_access_token.default.access_token
}
EOF
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

locals {
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = {

  billing_account = "012C9E-02C647-E8D293"
  org_id          = "490404241018"
  prefix_id       = "sb"

  policy_allowed_domain_ids = [
    # Cloud Identity Customer ID
    "C01otuiwz"
  ]

}
