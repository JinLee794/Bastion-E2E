#NSG15 rules - AzureBastionSubnet
# ref https://docs.microsoft.com/en-us/azure/bastion/bastion-nsg
# ----------- Inbound -----------
resource "azurerm_network_security_rule" "AllowGatewayManagerInbound" {
  name                        = "AllowGatewayManagerInbound"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow GatewayManager Inbound"
  destination_port_ranges    = ["443"]
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "GatewayManager"
  destination_address_prefix = "*"
  access                     = "Allow"
  priority                   = 130
  direction                  = "inbound"
}

resource "azurerm_network_security_rule" "AllowAzureLoadBalancerInbound" {
  name                        = "AllowAzureLoadBalancerInbound"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow Azure LoadBalancer Inbound"
  destination_port_ranges    = ["443"]
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "AzureLoadBalancer"
  destination_address_prefix = "*"
  access                     = "Allow"
  priority                   = 140
  direction                  = "inbound"
}

resource "azurerm_network_security_rule" "AllowBastionHostCommunication" {
  name                        = "AllowBastionHostCommunication"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow Bastion Host Communication To VNet"
  destination_port_ranges    = ["8080", "5701"]
  protocol                   = "*"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 150
  direction                  = "inbound"
}

#I wanted to restrict this to optum ip's but terraform would not build attach it to the subnet as incompatible rules to Azure Bastion Service <grrr>'
resource "azurerm_network_security_rule" "AllowHTTPSInbound" {
  name                        = "AllowHTTPSInbound"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  priority                   = 120
  direction                  = "inbound"
  access                     = "Allow"
  protocol                   = "TCP"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefix      = "Internet"
  destination_address_prefix = "*"
}
# ----------- Outbound -----------
resource "azurerm_network_security_rule" "AllowSshRdpOutbound" {
  name                        = "AllowSshRdpOutbound"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow SSH RDP Outbound"
  destination_port_ranges    = ["22", "3389"]
  protocol                   = "*"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 100
  direction                  = "outbound"
}

resource "azurerm_network_security_rule" "AllowAzureCloudOutbound" {
  name                        = "AllowAzureCloudOutbound"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow Azure Cloud Outbound"
  destination_port_ranges    = ["443"]
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "AzureCloud"
  access                     = "Allow"
  priority                   = 110
  direction                  = "outbound"
}

resource "azurerm_network_security_rule" "AllowBastionCommunication" {
  name                        = "AllowBastionCommunication"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow Bastion Communication Inbound"
  destination_port_ranges    = ["8080", "5701"]
  protocol                   = "*"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 120
  direction                  = "outbound"
}

resource "azurerm_network_security_rule" "AllowGetSessionInformation" {
  name                        = "AllowGetSessionInformation"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

  #  description                = "Allow Get Session Information"
  destination_port_ranges    = ["80"]
  protocol                   = "*"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "Internet"
  access                     = "Allow"
  priority                   = 130
  direction                  = "outbound"
}

resource "azurerm_network_security_rule" "NSG15_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG15Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG15Name

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