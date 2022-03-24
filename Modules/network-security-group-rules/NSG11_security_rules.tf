#NSG11 rules (plink01)
# ----------- Inbound -----------
resource "azurerm_network_security_rule" "NSG11_allow_Synapse_inbound_snet1" {
  name                        = "${var.NSG11Name}-synapse_inbound_snet1-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG11Name

  priority                     = 2000
  direction                    = "inbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefixes      = [var.subnet1CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
}

resource "azurerm_network_security_rule" "NSG11_allow_SQL_inbound_bastionvm" {
  name                        = "${var.NSG11Name}-SQL_inbound_bastionvm-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG11Name

  priority                     = 2010
  direction                    = "inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "1433"
  source_address_prefixes      = [var.subnet1CIDR, var.subnet10CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
}

resource "azurerm_network_security_rule" "NSG11_allow_bastion_inbound" {
  name                        = "${var.NSG11Name}-Allow_Bastion_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG11Name

  description                  = "Bastion inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet16CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
  access                       = "Allow"
  priority                     = 2020
  direction                    = "inbound"
}
# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG11_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG11Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG11Name

  priority                   = 1503
  direction                  = "outbound"
  access                     = "Allow"
  description                = "Publish Diagnostics Logs and Metrics, Resource Health, and Application Insights"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["1886", "443"]
  destination_address_prefix = "AzureMonitor"
}