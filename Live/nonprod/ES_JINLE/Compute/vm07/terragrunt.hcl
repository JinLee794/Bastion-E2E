terraform {
  source = "${local.module_repository}//virtual-machine"
}

dependency "resource_group" {
  config_path = "../resource-group"
  mock_outputs = {
    name = "bootstrap"
  }
}

dependency "resource_group_components" {
  config_path = "../resource-group-components"
  mock_outputs = {
    name = "bootstrap"
  }
}

dependency "virtual_network" {
  config_path = "../../Network/virtual-network"
  mock_outputs = {
    name        = "hub"
    id          = ""
    map_subnets = {}
  }
}

dependency "bastion_automation_account" {
  config_path = "../../Bastion/automation-account"
  mock_outputs = {
    bastion_automation_name = "bastion-infra-uat-aa"
  }
}


include {
  path = find_in_parent_folders()
}

locals {
  common_vars       = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  module_repository = local.common_vars.locals.module_repository

  layer_vars = read_terragrunt_config(find_in_parent_folders("layer.hcl"))
  layer_name = local.layer_vars.locals.layer_name

  env = get_env("ENV", "uat")
}

inputs = {
  resource_group_name            = dependency.resource_group.outputs.name
  resource_group_name_components = dependency.resource_group_components.outputs.name
  bastion_automation_name        = dependency.bastion_automation_account.outputs.bastion_automation_name
  subnet_id                      = lookup(dependency.virtual_network.outputs.map_subnets, "BastionVMSubnet").id

  vm_name = basename(get_terragrunt_dir())
}
