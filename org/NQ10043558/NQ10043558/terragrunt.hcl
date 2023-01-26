# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
locals {
}

terraform {
  source = "github.com/ajith4uuu/terraform-modules//stacks/project?ref=v1.0.0"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "parent" {
  config_path = "../NQ10043558/"
  mock_outputs = {
    folder_id = "NQ10043558"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  folder_id = dependency.parent.outputs.folder_id

  # Labels
  labels = {
    email       = "admin.ajith@sb.gcp.telefonica.de"
    costid      = ""
    live        = "yes"
    environment = "sandbox"
    servicename = "NQ10043558"
  }

  services = [
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "secretmanager.googleapis.com",
    "composer.googleapis.com",
    "bigquery.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerscanning.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
  ]

}
