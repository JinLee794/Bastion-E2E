
locals {
  tags = {}
}

# -
# - Network Security Group
# -
resource "azurerm_network_security_group" "this" {
  for_each            = var.network_security_groups
  name                = each.value["name"]
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = lookup(each.value, "security_rules", [])
    content {
      name                                       = security_rule.value["name"]
      description                                = lookup(security_rule.value, "description", null)
      protocol                                   = coalesce(security_rule.value["protocol"], "Tcp")
      direction                                  = security_rule.value["direction"]
      access                                     = coalesce(security_rule.value["access"], "Allow")
      priority                                   = security_rule.value["priority"]
      source_address_prefix                      = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes                    = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefix                 = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes               = lookup(security_rule.value, "destination_address_prefixes", null)
      source_port_range                          = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges                         = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_range                     = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges                    = lookup(security_rule.value, "destination_port_ranges", null)
    }
  }

  tags = merge(local.tags, coalesce(each.value.tags, {}))
}

locals {
  subnet_network_security_group_associations = {
    for k, v in var.network_security_groups : k => v if(v.subnet_id != null)
  }
}

# Associates a Network Security Group with a Subnet within a Virtual Network
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = local.subnet_network_security_group_associations
  network_security_group_id = azurerm_network_security_group.this[each.key]["id"]
  subnet_id                 = each.value.subnet_id
}
