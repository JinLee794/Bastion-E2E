#NSG17 rules - ACR plink
# ----------- Outbound -----------
resource "azurerm_network_security_rule" "NSG17_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG17Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG17Name

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
resource "azurerm_network_security_rule" "NSG17_allow_443_snet4-16_inbound" {
  name                        = "${var.NSG17Name}-443_snet4_inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG17Name

  priority                     = 1500
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefixes      = [var.subnet4CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet17CIDR]
}