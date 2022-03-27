terraform {
  source = "${local.module_repository}//network-security-group"
}

dependency "resource_group" {
  config_path = "../resource-group"
  mock_outputs = {
    name = "bootstrap"
  }
}

dependency "virtual_network" {
  config_path = "../virtual-network"
  mock_outputs = {
    name        = "hub"
    id          = ""
    map_subnets = {}
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

  Combined_AzureBastionSubnet_NSGRules     = setunion(local.layer_vars.locals.AzureBastionSubnet_NSGRules, local.layer_vars.locals.Common_NSGRules)
  Combined_BastionVMSubnet_NSGRules        = setunion(local.layer_vars.locals.BastionVMSubnet_NSGRules, local.layer_vars.locals.Common_NSGRules)
  Combined_KeyVaultPrivLinkSubnet_NSGRules = setunion(local.layer_vars.locals.KeyVaultPrivLinkSubnet_NSGRules, local.layer_vars.locals.Common_NSGRules)
}


inputs = {
  resource_group_name = dependency.resource_group.outputs.name

  network_security_groups = {
    AzureBastionSubnet_NSG = {
      name                      = "AzureBastionSubnet_NSGRule"
      tags                      = {}
      subnet_id                 = lookup(dependency.virtual_network.outputs.map_subnets, "AzureBastionSubnet").id
      networking_resource_group = null
      security_rules            = local.Combined_AzureBastionSubnet_NSGRules
    },
    BastionVMSubnet_NSG = {
      name                      = "BastionVMSubnet_NSGRule"
      tags                      = {}
      subnet_id                 = lookup(dependency.virtual_network.outputs.map_subnets, "BastionVMSubnet").id
      networking_resource_group = null
      security_rules            = local.Combined_BastionVMSubnet_NSGRules
    },
    KeyVaultPrivLinkSubnet = {
      name                      = "KeyVaultPrivLinkSubnet_NSGRule"
      tags                      = {}
      subnet_id                 = lookup(dependency.virtual_network.outputs.map_subnets, "KeyVaultPrivLinkSubnet").id
      networking_resource_group = null
      security_rules            = local.Combined_KeyVaultPrivLinkSubnet_NSGRules
    }
  }
}
