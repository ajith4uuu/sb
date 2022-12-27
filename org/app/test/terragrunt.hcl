# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
locals {
}

terraform {
  source = "github.com/ajith4uuu/terraform-modules//stacks/folder"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "env" {
  config_path = "../../app/"
  mock_outputs = {
    folder_id = "app"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  parent_folder = dependency.env.outputs.folder_id
  folder_name   = "test"

}
