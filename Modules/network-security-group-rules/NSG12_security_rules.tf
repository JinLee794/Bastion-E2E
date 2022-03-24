#NSG12 rules
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "NSG12_allow_SSL_Inbound" {
  name                        = "${var.NSG12Name}-AllowSSLInbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG12Name

  description                  = "Authproxy, Experience, Bastion inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet3CIDR, var.subnet4CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet12CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

resource "azurerm_network_security_rule" "NSG12_allow_Redis_Inbound" {
  name                        = "${var.NSG12Name}-AllowRedisInbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG12Name

  description                  = "Authproxy, Experience, Bastion Redis inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["6380"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet1CIDR, var.subnet2CIDR, var.subnet3CIDR, var.subnet4CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet12CIDR]
  access                       = "Allow"
  priority                     = 2010
  direction                    = "inbound"
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG12_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG12Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG12Name

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