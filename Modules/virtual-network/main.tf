resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = var.tags


  // ddos_protection_plan {
  //   id     = data.azurerm_network_ddos_protection_plan.DDoS_Plan.id
  //   enable = true
  // }
}


resource "azurerm_subnet" "this" {
  for_each                                       = var.subnets
  name                                           = each.key
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = each.value["address_prefixes"]
  service_endpoints                              = lookup(each.value, "service_endpoints", null)

  enforce_private_link_endpoint_network_policies = coalesce(lookup(each.value, "enforce_private_link_endpoint_network_policies"), false)
  enforce_private_link_service_network_policies  = coalesce(lookup(each.value, "enforce_private_link_service_network_policies"), false)
  virtual_network_name                           = azurerm_virtual_network.this.name
  depends_on = [azurerm_virtual_network.this]
}
