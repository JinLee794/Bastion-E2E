terraform {
  source = "${local.module_repository}//private-dns-zone"
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
    name = "hub"
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
  vnet_name           = dependency.virtual_network.outputs.name
  private_dns_zones = {
    azure-websites = "privatelink.azurewebsites.net",
    redis-cache    = "privatelink.redis.cache.windows.net",
    azure-net      = "privatelink.vaultcore.azure.net",
    azure-synapse  = "privatelink.sql.azuresynapse.net",
    private-link   = "privatelink.azurecr.io",
    blob-core-io   = "privatelink.blob.core.windows.net",
    dfs-core       = "dfs.core.windows.net"
  }
}
