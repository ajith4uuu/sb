# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
locals {
}

terraform {
  source = "github.com/ajith4uuu/terraform-modules//stacks/iam_project"

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "parent" {
  config_path = "../../sand-prod-app/"
  mock_outputs = {
    project = {
      project_id = "sand-prod-app"
    }
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id = dependency.parent.outputs.project.project_id

  editor_members = [
    "user:admin.ajith@sb.gcp.telefonica.de",
    "user:admin.sebastian@sb.gcp.telefonica.de",
  ]

}
