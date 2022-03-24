#https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_zone
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link DNS Zone to the configured VNET
resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vnet_link" {
  name                  = "plnk-${var.private_dns_zone}-pdp-${var.environment}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = var.registration_enabled
  tags                  = var.tags
}