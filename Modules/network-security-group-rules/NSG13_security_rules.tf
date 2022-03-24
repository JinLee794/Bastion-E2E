#NSG13 rules
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "NSG13_allow_bastion_inbound" {
  name                        = "${var.NSG13Name}-Allow_Bastion_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG13Name

  description                  = "Bastion inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet16CIDR]
  destination_address_prefixes = [var.subnet13CIDR]
  access                       = "Allow"
  priority                     = 2010
  direction                    = "inbound"
}

resource "azurerm_network_security_rule" "NSG13_allow_authproxy_Inbound" {
  name                        = "${var.NSG13Name}-AllowAuthProxyInbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG13Name

  description                  = "Authproxy inbound rule."
  protocol                     = "*"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet4CIDR]
  destination_address_prefixes = [var.subnet13CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

resource "azurerm_network_security_rule" "NSG13_allow_AppGW_Inbound" {
  name                        = "${var.NSG13Name}-AllowAppGw_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG13Name

  description                  = "AppGw inbound rule."
  protocol                     = "*"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet5CIDR]
  destination_address_prefixes = [var.subnet13CIDR]
  access                       = "Allow"
  priority                     = 1999
  direction                    = "inbound"
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG13_allow_experience_and_apim_outbound" {
  name                        = "${var.NSG13Name}-AllowExperience-APIM_Outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG13Name

  description                  = "Experience & APIM outbound rule."
  protocol                     = "*"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet13CIDR]
  destination_address_prefixes = [var.subnet2CIDR, var.subnet3CIDR, var.subnet4CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "outbound"
}

resource "azurerm_network_security_rule" "NSG13_allow_OneHealthCareID_Outbound" {
  name                        = "${var.NSG13Name}-OneHealthCareID_Outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG13Name

  description                = "OneHealthCareID outbound rule."
  protocol                   = "*"
  destination_port_ranges    = ["443"]
  source_port_range          = "*"
  source_address_prefixes    = [var.subnet13CIDR]
  destination_address_prefix = "Internet"
  access                     = "Allow"
  priority                   = 1999
  direction                  = "outbound"
}

resource "azurerm_network_security_rule" "NSG13_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG13Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG13Name

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