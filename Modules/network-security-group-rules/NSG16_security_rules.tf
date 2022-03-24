#NSG16 rules - bastion VM subnet
# ref https://docs.microsoft.com/en-us/azure/bastion/bastion-nsg

# ----------- Inbound -----------
resource "azurerm_network_security_rule" "AllowSSHRDPFromBastionInbound" {
  name                        = "${var.NSG16Name}-AllowSSHRDPFromBastionInbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG16Name

  priority                     = 100
  direction                    = "inbound"
  access                       = "Allow"
  description                  = "Allow SSH RDP Inbound From Bastion service"
  destination_port_ranges      = ["22", "3389"]
  protocol                     = "*"
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet15CIDR]
  destination_address_prefixes = [var.subnet16CIDR]
}

# ---------- Outbound ----------

resource "azurerm_network_security_rule" "NSG16_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG16Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG16Name

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

resource "azurerm_network_security_rule" "NSG16_allow_SynapseWorkspace_outbound_1433_443" {
  name                        = "${var.NSG16Name}-SynapseWorkspace_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG16Name

  priority                     = 2000
  direction                    = "outbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_ranges      = ["1433", "443"]
  source_address_prefixes      = [var.subnet16CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
}

resource "azurerm_network_security_rule" "NSG16_allow_Redis_outbound_6380" {
  name                        = "${var.NSG16Name}-Redis_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG16Name

  priority                     = 2222
  direction                    = "outbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_ranges      = ["6380"]
  source_address_prefixes      = [var.subnet16CIDR]
  destination_address_prefixes = [var.subnet12CIDR]
}

resource "azurerm_network_security_rule" "NSG16_allow_internet_outbound_http_https" {
  name                        = "${var.NSG16Name}-internet_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG16Name

  priority                   = 2233
  direction                  = "outbound"
  access                     = "Allow"
  protocol                   = "TCP"
  source_port_range          = "*"
  destination_port_ranges    = ["443", "80"]
  source_address_prefixes    = [var.subnet16CIDR]
  destination_address_prefix = "Internet"
}