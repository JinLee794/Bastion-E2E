#NSG6 rules - app service incoming
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "NSG6_allow_experience_inbound" {
  name                        = "${var.NSG6Name}-AllowExperience_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG6Name

  description                  = "Experience inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet3CIDR, var.subnet4CIDR, var.subnet5CIDR, var.subnet13CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet6CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG6_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG6Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG6Name

  priority                   = 1503
  direction                  = "Outbound"
  access                     = "Allow"
  description                = "Publish Diagnostics Logs and Metrics, Resource Health, and Application Insights"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["1886", "443"]
  destination_address_prefix = "AzureMonitor"
}

resource "azurerm_network_security_rule" "NSG6_allow_443_outbound" {
  name                        = "${var.NSG6Name}-Allow443_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG6Name

  description                  = "443 outbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet6CIDR]
  destination_address_prefixes = [var.subnet2CIDR, var.subnet3CIDR, var.subnet13CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "outbound"
}

resource "azurerm_network_security_rule" "NSG6_allow_443_inet_outbound" {
  name                        = "${var.NSG6Name}-Allow443_inet_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG6Name

  description                = "443 outbound rule to inet."
  protocol                   = "TCP"
  destination_port_ranges    = ["443"]
  source_port_range          = "*"
  source_address_prefixes    = [var.subnet6CIDR]
  destination_address_prefix = "Internet"
  access                     = "Allow"
  priority                   = 1999
  direction                  = "outbound"
}