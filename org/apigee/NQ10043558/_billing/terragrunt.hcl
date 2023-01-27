# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
locals {
}

terraform {

  source = "github.com/terraform-google-modules/terraform-google-project-factory/tree/v14.1.0/modules/budget"

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "parent" {
  config_path = "../../NQ10043558/"
  mock_outputs = {
    project = {
      project_id = "NQ10043558"
    }
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id = dependency.parent.outputs.project.project_id

  billing_account = "012C9E-02C647-E8D293"

  amount = "100"

  alert_pubsub_topic = "projects/sb-shr-terraform-178c/subscriptions/sb-budget-capping-sub"

}
