#NSG4 rules - app service outgoing
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "NSG4_allow_experience_inbound" {
  name                        = "${var.NSG4Name}-AllowExperience_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG4Name

  description                  = "Experience inbound rule."
  protocol                     = "*"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet3CIDR, var.subnet13CIDR]
  destination_address_prefixes = [var.subnet4CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

resource "azurerm_network_security_rule" "NSG4_allow_AppGW_Inbound" {
  name                        = "${var.NSG4Name}-AllowAppGw_Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG4Name

  description                  = "AppGw inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet5CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet4CIDR]
  access                       = "Allow"
  priority                     = 1999
  direction                    = "inbound"
}

# ---------- Outbound ----------
#168.63.129.16
# resource "azurerm_network_security_rule" "NSG4_allow_AzureDNS_outbound" {
#   name                        = "${var.NSG4Name}-AllowAzureDNSOutbound-${var.environment}"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = var.NSG4Name

#   priority                   = 1502
#   direction                  = "outbound"
#   access                     = "Allow"
#   description                = "Allow query of Azure DNS"
#   protocol                   = "*"
#   source_port_range          = "*"
#   source_address_prefixes    = [var.subnet4CIDR]
#   destination_port_ranges    = ["53"]
#   destination_address_prefix = "168.63.129.16/32"
# }

resource "azurerm_network_security_rule" "NSG4_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG4Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG4Name

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

resource "azurerm_network_security_rule" "NSG4_allow_experience_and_apim_outbound" {
  name                        = "${var.NSG4Name}-AllowExperience-APIM_Outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG4Name

  priority                     = 2000
  direction                    = "outbound"
  access                       = "Allow"
  description                  = "Experience & APIM outbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet4CIDR]
  destination_address_prefixes = [var.subnet2CIDR, var.subnet3CIDR, var.subnet6CIDR, var.subnet13CIDR]
}

resource "azurerm_network_security_rule" "NSG4_allow_OneHealthCareID_Outbound" {
  name                        = "${var.NSG4Name}-OneHealthCareID_Outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG4Name

  priority                   = 1999
  direction                  = "outbound"
  access                     = "Allow"
  description                = "OneHealthCareID outbound rule."
  protocol                   = "*"
  destination_port_ranges    = ["443"]
  source_port_range          = "*"
  source_address_prefixes    = [var.subnet4CIDR]
  destination_address_prefix = "Internet"
}

resource "azurerm_network_security_rule" "NSG4_allow_Redis_Outbound" {
  name                        = "${var.NSG4Name}-Redis_Outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG4Name

  priority                   = 1998
  direction                  = "outbound"
  access                     = "Allow"
  description                = "Redis outbound rule."
  protocol                   = "*"
  destination_port_ranges    = ["6380"]
  source_port_range          = "*"
  source_address_prefixes    = [var.subnet4CIDR]
  destination_address_prefix = "Internet"
}