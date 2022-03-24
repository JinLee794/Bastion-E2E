resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  address_space       = var.vnet_CIDR
  resource_group_name = var.resource_group_name
  dns_servers         = []
  tags                = var.tags
  ddos_protection_plan {
    id     = data.azurerm_network_ddos_protection_plan.DDoS_Plan.id
    enable = true
  }
}