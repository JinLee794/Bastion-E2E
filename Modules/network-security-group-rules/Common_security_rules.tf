#Common NSG rules
# Pull in the module for getting the optum ips
module "optum_ips" {
  source = "git::https://github.optum.com/O360Dojo/optum-ips"
}
# ---------- Inbound ----------
resource "azurerm_network_security_rule" "Common_NSG_deny_all_inbound" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-DenyAllInboundTraffic-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 4003
  direction                  = "inbound"
  access                     = "Deny"
  description                = "Denies all inbound traffic."
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

#to be removed after all rules set
resource "azurerm_network_security_rule" "Common_NSG_allow_vnet_inbound" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-vnet_inbound-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 4001
  direction                  = "inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "Common_NSG_allow_inbound_azure_load_balancer" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-AllowInboundAzureLoadBalancer-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 4000
  direction                  = "inbound"
  access                     = "Allow"
  description                = "Allow inbound access from Azure Load Balancer."
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "AzureLoadBalancer"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "Common_NSG_optum_network_security_rule" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-AllowOptumHttpsInbound-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 200
  direction                  = "inbound"
  access                     = "Allow"
  protocol                   = "tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefixes    = module.optum_ips.tower_ips
  destination_address_prefix = "*"
}

# ---------- Outbound ----------
#to be removed after all rules set
resource "azurerm_network_security_rule" "Common_NSG_allow_vnet_outbound" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-vnet_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 4001
  direction                  = "outbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "Common_NSG_allow_azurecloud_outbound" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-AllowAzureCloudOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 4002
  description                = "Azure Cloud Outbound rule."
  access                     = "Allow"
  protocol                   = "*"
  destination_port_ranges    = ["443", "9000"] # Add 22 for AKS deployment
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "AzureCloud.${var.location}"
  direction                  = "outbound"
}

resource "azurerm_network_security_rule" "Common_NSG_deny_all_outbound" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-DenyAllOutboundTraffic-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                   = 4003
  direction                  = "outbound"
  access                     = "Deny"
  description                = "Denies all outbound traffic."
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "Common_NSG_allow_AzureDNS_outbound_53" {
  count                       = length(var.NSGNames)
  network_security_group_name = var.NSGNames[count.index]
  name                        = "Common-AllowAzureDNSOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name

  priority                     = 1234
  direction                    = "outbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_ranges      = ["53"]
  source_address_prefix        = "*"
  destination_address_prefixes = ["168.63.129.16/32"]
}