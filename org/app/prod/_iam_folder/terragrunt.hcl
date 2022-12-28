# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
locals {
}

terraform {
  source = "github.com/ajith4uuu/terraform-modules//stacks/iam_folder"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "env" {
  config_path = "../../prod/"
  mock_outputs = {
    folder_id = "prod"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  folder_id = dependency.env.outputs.folder_id

  editor_members = [
  ]

}
