#NSG1 rules - tenantapi01
# ---------- Inbound ----------

resource "azurerm_network_security_rule" "NSG1_allow_snet_2_inbound_443" {
  name                        = "${var.NSG1Name}-snet_2_inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG1Name

  priority                     = 1500
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefixes      = [var.subnet2CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet1CIDR]
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG1_allow_DBredirect_outbound" {
  name                        = "${var.NSG1Name}-DBredirect_outbound_snet11-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG1Name

  priority                     = 2000
  direction                    = "outbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefixes      = [var.subnet1CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
}

resource "azurerm_network_security_rule" "NSG1_allow_SynapseWorkspace_outbound_1433" {
  name                        = "${var.NSG1Name}-SynapseWorkspace_outbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG1Name

  priority                     = 1999
  direction                    = "outbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_ranges      = ["1433"]
  source_address_prefixes      = [var.subnet1CIDR]
  destination_address_prefixes = [var.subnet11CIDR]
}

resource "azurerm_network_security_rule" "NSG1_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG1Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG1Name

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

resource "azurerm_network_security_rule" "NSG1_allow_MSContainerRegistry_outbound" {
  name                        = "${var.NSG1Name}-AllowMSContainerRegistryOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG1Name

  priority                   = 2345
  direction                  = "outbound"
  access                     = "Allow"
  description                = "Allow pods to pull updates from MCS"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefixes    = [var.subnet1CIDR]
  destination_port_ranges    = ["443"]
  destination_address_prefix = "Internet"
}

resource "azurerm_network_security_rule" "NSG1_allow_EventHubLogs_outbound" {
  name                        = "${var.NSG1Name}-AllowEventHubLogsOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG1Name

  priority                   = 1200
  direction                  = "outbound"
  access                     = "Allow"
  description                = "Allow output to event hubs for AKS logging"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefixes    = [var.subnet1CIDR]
  destination_port_ranges    = ["9093"]
  destination_address_prefix = "EventHub.CentralUS"
}