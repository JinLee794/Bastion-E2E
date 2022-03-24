#NSG10 rules
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "NSG10_allow_bastion_inbound" {
  name                        = "${var.NSG10Name}-Allow_Bastion_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG10Name

  description                  = "Bastion inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet16CIDR]
  destination_address_prefixes = [var.subnet10CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG10_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG10Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG10Name

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

resource "azurerm_network_security_rule" "NSG10_allow_SynapseWorkspace_outbound_1433" {
  name                        = "${var.NSG10Name}-SynapseWorkspace_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG10Name

  priority                     = 2000
  direction                    = "outbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_ranges      = ["1433"]
  source_address_prefixes      = [var.subnet10CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
}