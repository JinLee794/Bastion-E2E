terraform {
  source = "${local.module_repository}//virtual-network"
}

dependency "resource_group" {
  config_path = "../resource-group"
  mock_outputs = {
    name = "bootstrap"
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
  resource_group_name = dependency.resource_group.outputs.name
  name                = "${local.layer_name}-${local.env}-vnet"
  address_space       = ["10.1.0.0/16"]

  subnets = {
    AzureBastionSubnet = {
      address_prefixes                               = ["10.1.0.0/26"]
      service_endpoints                              = []
      enforce_private_link_endpoint_network_policies = true
      enforce_private_link_service_network_policies  = true
    },
    BastionVMSubnet = {
      address_prefixes                               = ["10.1.1.0/26"]
      service_endpoints                              = ["Microsoft.Web", "Microsoft.Storage", "Microsoft.KeyVault"]
      enforce_private_link_service_network_policies  = true
      enforce_private_link_endpoint_network_policies = true
    },
    IaCProvisionerSubnet = {
      address_prefixes                               = ["10.1.2.0/28"]
      service_endpoints                              = []
      enforce_private_link_endpoint_network_policies = false
      enforce_private_link_service_network_policies  = false
    },
    KeyVaultPrivLinkSubnet = {
      address_prefixes                               = ["10.1.3.0/28"]
      service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Storage"]
      enforce_private_link_endpoint_network_policies = true
      enforce_private_link_service_network_policies  = true
    }
  }
}


# #Azure Bastion Service
# resource "azurerm_subnet" "this" {
#   for_each = var.subnets

#   name                                           = var.subnet15Name
#   virtual_network_name                           = var.vnet_name
#   resource_group_name                            = var.resource_group_name
#   address_prefixes                               = "10.1.0.0/26"
#   enforce_private_link_endpoint_network_policies = true
#   enforce_private_link_service_network_policies  = true
# }

# #Bastion VM
# resource "azurerm_subnet" "subnet_16" {
#   name                                           = "${var.subnet16Name}-${var.environment}"
#   virtual_network_name                           = var.vnet_name
#   resource_group_name                            = var.resource_group_name
#   address_prefixes                               = var.subnet16CIDR
#   service_endpoints                              = ["Microsoft.Web", "Microsoft.Storage", "Microsoft.KeyVault"]
#   enforce_private_link_endpoint_network_policies = true
#   enforce_private_link_service_network_policies  = true
# }
