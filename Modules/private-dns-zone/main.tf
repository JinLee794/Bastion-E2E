#https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns

resource "azurerm_private_dns_zone" "this" {
  for_each = var.private_dns_zones
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link DNS Zone to the configured VNET
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.private_dns_zones

  name                  = "${lookup(var.private_dns_zones, each.key)}-link"

  resource_group_name   = var.resource_group_name
  private_dns_zone_name = each.value
  virtual_network_id    = data.azurerm_virtual_network.this.id
  registration_enabled  = var.registration_enabled
  tags                  = var.tags

  depends_on            = [azurerm_private_dns_zone.this]
}


// # -
// # - Private DNS Zone to VNet Link
// # -
// resource "azurerm_private_dns_zone_virtual_network_link" "this" {
//   for_each              = local.zone_to_vnet_links
//   name                  = substr(coalesce(each.value.zone_to_vnet_link_name, "${each.value["dns_zone_name"]}-${each.value["vnet_name"]}-link"), 0, 80)
//   resource_group_name   = var.resource_group_name
//   private_dns_zone_name = azurerm_private_dns_zone.this[each.value.dns_zone_key].name
//   virtual_network_id    = local.networking_state_exists == true ? lookup(data.terraform_remote_state.networking.outputs.map_vnet_ids, each.value.vnet_name) : lookup(data.azurerm_virtual_network.this, "${each.value.dns_zone_key}_${each.value.zone_to_vnet_link_name}")["id"]
//   registration_enabled  = coalesce(each.value.registration_enabled, true)
//   tags                  = local.tags
//   depends_on            = [azurerm_private_dns_zone.this]
// }
