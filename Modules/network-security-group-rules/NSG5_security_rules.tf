#NSG5 rules - Application Gateway
# ---------- outbound ----------
resource "azurerm_network_security_rule" "NSG5_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG5Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG5Name
  priority                    = 1503
  direction                   = "Outbound"
  access                      = "Allow"
  description                 = "Publish Diagnostics Logs and Metrics, Resource Health, and Application Insights"
  protocol                    = "TCP"
  source_port_range           = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_port_ranges     = ["1886", "443"]
  destination_address_prefix  = "AzureMonitor"
}

#AzureKeyVault
resource "azurerm_network_security_rule" "NSG5_allow_AzureKeyVault_outbound" {
  name                        = "${var.NSG5Name}-AllowAzureKeyVaultOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG5Name
  priority                    = 1504
  direction                   = "Outbound"
  access                      = "Allow"
  description                 = "access Azure KeyVaults"
  protocol                    = "TCP"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_ranges     = ["443"]
  destination_address_prefix  = "AzureKeyVault"
}

# resource "azurerm_network_security_rule" "NSG5_Deny_All_OutBound" {
#   name                         = "${var.NSG5Name}-DenyAllOutBound-${var.environment}"
#   resource_group_name          = var.resource_group_name
#   network_security_group_name  = var.NSG5Name
#   priority                     = 4096
#   direction                    = "Outbound"
#   access                       = "Deny"
#   description                  = "Deny all outbound rule"
#   destination_address_prefix   = "*"
#   destination_address_prefixes = null
#   destination_port_range       = "*"
#   destination_port_ranges      = null
#   protocol                     = "*"
#   source_address_prefix        = "*"
#   source_address_prefixes      = null
#   source_port_range            = "*"
#   source_port_ranges           = null
# }

resource "azurerm_network_security_rule" "NSG5_allow_vnet_outbound_443" {
  name                         = "${var.NSG5Name}-AllowOutNSG4-443-${var.environment}"
  resource_group_name          = var.resource_group_name
  network_security_group_name  = var.NSG5Name
  priority                     = 2000
  direction                    = "Outbound"
  access                       = "Allow"
  description                  = "NSG5_allow_outbound_Vnet_443"
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet5CIDR]
  destination_address_prefixes = [var.vnet_CIDR]
}

# ---------- inbound ----------
resource "azurerm_network_security_rule" "NSG5_Allow_Application_GatewayV2_InBound" {
  name                        = "${var.NSG5Name}-AllowApplicationGatewayV2InBound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG5Name

  priority                   = 2000
  direction                  = "Inbound"
  access                     = "Allow"
  description                = "Allow 65200-65535 for Application Gateway v2"
  destination_address_prefix = "*"
  destination_port_range     = "65200-65535"
  protocol                   = "*"
  source_address_prefix      = "GatewayManager"
  source_port_range          = "*"
}

resource "azurerm_network_security_rule" "NSG5_Allow_SSL_InBound" {
  name                        = "${var.NSG5Name}-AllowSSLInBound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG5Name

  priority                     = 4096
  direction                    = "Inbound"
  access                       = "Allow"
  description                  = "Allow SSL inbound rule"
  destination_address_prefixes = [var.subnet5CIDR]
  destination_port_range       = "443"
  protocol                     = "TCP"
  source_address_prefix        = "Internet"
  source_port_range            = "*"
}

resource "azurerm_network_security_rule" "NSG5_Allow_HTTP_InBound" {
  name                        = "${var.NSG5Name}-AllowHTTPInBound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG5Name

  priority                     = 4095
  direction                    = "Inbound"
  access                       = "Allow"
  description                  = "Allow HTTP inbound rule"
  destination_address_prefixes = [var.subnet5CIDR]
  destination_port_range       = "80"
  protocol                     = "TCP"
  source_address_prefix        = "Internet"
  source_port_range            = "*"
}