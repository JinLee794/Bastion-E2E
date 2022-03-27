# common.hcl
#
# This file contains commonly shared parameters across multiple environments
# Contents of this file becomes merged into the inputs for any of the Terragrunt
#   deployments found under this directory. This behavior can be changed with the root
#   terragrunt.hcl file (/Live/terragrunt.hcl)
#

locals {
  tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"

  # Backend Remote State Provider for nonprod subscriptions
  backend_subscription_id             = "7386cd39-b109-4cc6-bb80-bf12413d0a99"
  backend_storage_account_name        = "bootstrapsadev"
  backend_storage_resource_group_name = "bootstrap"

  # Configure the source of the modules (can be replaced with git repo. Private registry
  #   will require additional configuration changes)
  module_repository = "${get_parent_terragrunt_dir()}/../../Modules"
  // module_repository_version = "demo"

  # Shared key-vault and log analytics workspace for nonprod configuration values
  az_workspace_id       = "9aa65e21-29c8-44ec-aa57-0811a4a90dfe"
  az_law_id             = "/subscriptions/7386cd39-b109-4cc6-bb80-bf12413d0a99/resourcegroups/bootstrap/providers/microsoft.operationalinsights/workspaces/sandbox-law"
  law_key_vault_name    = "bootstrap-iac-kv"
  law_key_vault_rg_name = "bootstrap"
  law_key_name          = "sandbox-law-win-primary-key"
}
