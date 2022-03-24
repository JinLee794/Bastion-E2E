#NSG7 rules
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "NSG7_allow_bastion_inbound" {
  name                        = "${var.NSG7Name}-Allow_Bastion_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG7Name

  description                  = "Bastion inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet16CIDR]
  destination_address_prefixes = [var.subnet7CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG7_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG7Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG7Name

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