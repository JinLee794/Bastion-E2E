#NSG3 rules - experienceapi01
# ----------- Outbound -----------

resource "azurerm_network_security_rule" "NSG3_allow_Redis_Outbound" {
  name                        = "${var.NSG3Name}-Redis_Outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG3Name

  description                  = "Redis outbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["6380"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet3CIDR]
  destination_address_prefixes = [var.subnet12CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "outbound"
}

resource "azurerm_network_security_rule" "NSG3_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG3Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG3Name

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

# ----------- Inbound -----------
resource "azurerm_network_security_rule" "NSG3_allow_443_snet4_inbound" {
  name                        = "${var.NSG3Name}-443_snet4_inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG3Name

  priority                     = 1500
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefixes      = [var.subnet4CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet3CIDR]
}