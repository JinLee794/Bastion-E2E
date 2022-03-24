#Create a Private Endpoint to the in the configured VNET and link the Private DNS Zone,
#this will also generate read only network interface
resource "azurerm_private_endpoint" "pep-app-gw" {
  name                = "pep-appgw01-pdp-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet5_ID
  private_dns_zone_group {
    name                 = "pdnszg-appgw01-pdp-${var.environment}"
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }
  private_service_connection {
    name                           = "psc-appgw01-pdp-${var.environment}"
    private_connection_resource_id = data.azurerm_key_vault.kv_network_core.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }
}