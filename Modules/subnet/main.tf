#tenantapi01
resource "azurerm_subnet" "subnet_1" {
  name                                           = "${var.subnet1Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet1CIDR
  service_endpoints                              = ["Microsoft.KeyVault"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#apim01
resource "azurerm_subnet" "subnet_2" {
  name                                           = "${var.subnet2Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet2CIDR
  service_endpoints                              = ["Microsoft.KeyVault"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#experienceapi01
resource "azurerm_subnet" "subnet_3" {
  name                                           = "${var.subnet3Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet3CIDR
  service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Web"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
  delegation {
    name = "snet3-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

#pdpreact01
resource "azurerm_subnet" "subnet_4" {
  name                                           = "${var.subnet4Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet4CIDR
  service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Web"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
  delegation {
    name = "snet4-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

#appgw01
resource "azurerm_subnet" "subnet_5" {
  name                                           = "${var.subnet5Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet5CIDR
  service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Web"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#spare
resource "azurerm_subnet" "subnet_6" {
  name                                           = "${var.subnet6Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet6CIDR
  service_endpoints                              = ["Microsoft.Web"]
  enforce_private_link_service_network_policies  = true
  enforce_private_link_endpoint_network_policies = true
}

#adf01
resource "azurerm_subnet" "subnet_7" {
  name                                           = "${var.subnet7Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet7CIDR
  service_endpoints                              = ["Microsoft.KeyVault"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#func01
resource "azurerm_subnet" "subnet_10" {
  name                                           = "${var.subnet10Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet10CIDR
  service_endpoints                              = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true

  delegation {
    name = "Delegation for Azure Functions"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

#plink01
resource "azurerm_subnet" "subnet_11" {
  name                                           = "${var.subnet11Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet11CIDR
  service_endpoints                              = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_service_network_policies  = true
  enforce_private_link_endpoint_network_policies = true
}

#rediscache01
resource "azurerm_subnet" "subnet_12" {
  name                                           = "${var.subnet12Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet12CIDR
  service_endpoints                              = ["Microsoft.KeyVault"]
  enforce_private_link_service_network_policies  = true
  enforce_private_link_endpoint_network_policies = true
}

#authproxy01
resource "azurerm_subnet" "subnet_13" {
  name                                           = "${var.subnet13Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet13CIDR
  service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Web"]
  enforce_private_link_service_network_policies  = true
  enforce_private_link_endpoint_network_policies = true
}

#plink-web-keyvault
resource "azurerm_subnet" "subnet_14" {
  name                                           = "${var.subnet14Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet14CIDR
  service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Storage"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#Azure Bastion Service
resource "azurerm_subnet" "subnet_15" {
  name                                           = var.subnet15Name
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet15CIDR
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#Bastion VM
resource "azurerm_subnet" "subnet_16" {
  name                                           = "${var.subnet16Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet16CIDR
  service_endpoints                              = ["Microsoft.Web", "Microsoft.Storage", "Microsoft.KeyVault"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#Azure Container Registry
resource "azurerm_subnet" "subnet_17" {
  name                                           = "${var.subnet17Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet17CIDR
  service_endpoints                              = ["Microsoft.ContainerRegistry"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

#plink-experience-api
resource "azurerm_subnet" "subnet_18" {
  name                                           = "${var.subnet18Name}-${var.environment}"
  virtual_network_name                           = var.vnet_name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.subnet18CIDR
  service_endpoints                              = ["Microsoft.Web"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}