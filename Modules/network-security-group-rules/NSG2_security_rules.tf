#NSG2 rules
# ---------- Inbound ----------
#Management endpoint for Azure portal and PowerShell
resource "azurerm_network_security_rule" "NSG2_allow_apimanagement_inbound" {
  name                        = "${var.NSG2Name}-AllowApiManagement-Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Management endpoint for Azure portal and PowerShell"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "ApiManagement"
  destination_port_range     = "3443"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 1500
  direction                  = "Inbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_authproxy_Inbound" {
  name                        = "${var.NSG2Name}-AllowAuthProxy-Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                  = "Authproxy inbound rule."
  protocol                     = "TCP"
  destination_port_ranges      = ["443"]
  source_port_range            = "*"
  source_address_prefixes      = [var.subnet4CIDR, var.subnet16CIDR]
  destination_address_prefixes = [var.subnet2CIDR]
  access                       = "Allow"
  priority                     = 2000
  direction                    = "inbound"
}

#Client communication to API Management
resource "azurerm_network_security_rule" "NSG2_Client_communication_to_API_Management_Inbound" {
  name                        = "${var.NSG2Name}-AllowClientCommunicationAPIManagement-Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "ClientCommunicationAPIManagement inbound rule."
  protocol                   = "TCP"
  destination_port_ranges    = ["443", "80"]
  source_port_range          = "*"
  source_address_prefix      = "Internet"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 2010
  direction                  = "inbound"
}

#AllowRedisServiceCachePoliciesBetweenMachines
resource "azurerm_network_security_rule" "NSG2_Access_Redis_Service_for_Cache_policies_between_machines_Inbound" {
  name                        = "${var.NSG2Name}-AllowRedisServiceCachePoliciesBetweenMachines-Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "AllowRedisServiceCachePoliciesBetweenMachines inbound rule."
  protocol                   = "TCP"
  destination_port_ranges    = ["6381 - 6383"]
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 2020
  direction                  = "inbound"
}


#Sync Counters for Rate Limit policies between machines
resource "azurerm_network_security_rule" "NSG2_Sync_Counters_for_Rate_Limit_policies_between_machines_Inbound" {
  name                        = "${var.NSG2Name}-SyncCountersRateLimitPoliciesBetweenMachines-Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Sync Counters for Rate Limit policies between machines inbound rule."
  protocol                   = "UDP"
  destination_port_ranges    = ["4290"]
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 2030
  direction                  = "inbound"
}

#Azure Infrastructure Load Balancer
resource "azurerm_network_security_rule" "NSG2_Azure_Infrastructure_Load_Balancer_Inbound" {
  name                        = "${var.NSG2Name}-AzureInfrastructureLoadBalancer-Inbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Azure_Infrastructure_Load_Balancer inbound rule."
  protocol                   = "TCP"
  destination_port_ranges    = ["6390"]
  source_port_range          = "*"
  source_address_prefix      = "AzureLoadBalancer"
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 222
  direction                  = "inbound"
}

# ---------- Outbound ----------
resource "azurerm_network_security_rule" "NSG2_allow_storage_outbound" {
  name                        = "${var.NSG2Name}-AllowAzureStorageOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Dependency on Azure Storage"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_range     = "443"
  destination_address_prefix = "Storage"
  access                     = "Allow"
  priority                   = 1500
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_sql-endpoint_outbound" {
  name                        = "${var.NSG2Name}-AllowSQLOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Access to Azure SQL endpoints"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_range     = "1433"
  destination_address_prefix = "SQL"
  access                     = "Allow"
  priority                   = 1501
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_keyvault_outbound" {
  name                        = "${var.NSG2Name}-AllowAzureKeyvaultOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Access to Azure KeyVault"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_range     = "443"
  destination_address_prefix = "AzureKeyVault"
  access                     = "Allow"
  priority                   = 1502
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_AzureMonitor_outbound" {
  name                        = "${var.NSG2Name}-AllowAzureMonitorOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Publish Diagnostics Logs and Metrics, Resource Health, and Application Insights"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["1886", "443"]
  destination_address_prefix = "AzureMonitor"
  access                     = "Allow"
  priority                   = 1503
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_AAD_outbound" {
  name                        = "${var.NSG2Name}-AllowAzureADOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Dependency on Azure AD"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_range     = "443"
  destination_address_prefix = "AzureActiveDirectory"
  access                     = "Allow"
  priority                   = 1504
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_GIT_storage_outbound" {
  name                        = "${var.NSG2Name}-AllowAzureGITStorageOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Dependency on Azure Storage for GIT"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_range     = "445"
  destination_address_prefix = "Storage"
  access                     = "Allow"
  priority                   = 1505
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_Log_to_Event_Hub_outbound" {
  name                        = "${var.NSG2Name}-AllowLogtoEventHubOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Log to Event Hub"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["445", "5671", "5672"]
  destination_address_prefix = "EventHub"
  access                     = "Allow"
  priority                   = 1506
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_Health_and_Monitoring_Extension_outbound" {
  name                        = "${var.NSG2Name}-AllowHealthandMonitoringExtensionOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Health and Monitoring Extension"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["443", "12000"]
  destination_address_prefix = "AzureCloud"
  access                     = "Allow"
  priority                   = 1507
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_allow_Connect_SMTP_Relay_for_sending_e-mails_outbound" {
  name                        = "${var.NSG2Name}-AllowConnectSMTPRelayOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Connect to SMTP Relay for sending e-mails"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["25", "587", "25028"]
  destination_address_prefix = "Internet"
  access                     = "Allow"
  priority                   = 1508
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_Access_Redis_Service_for_Cache_policies_between_machines_outbound" {
  name                        = "${var.NSG2Name}-AllowRedisServiceCachePoliciesBetweenMachinesOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Access Redis Service for Cache policies between machines"
  protocol                   = "TCP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["6381-6383"]
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 1509
  direction                  = "Outbound"
}

resource "azurerm_network_security_rule" "NSG2_Sync_Counters_for_Rate_Limit_policies_between_machines_outbound" {
  name                        = "${var.NSG2Name}-AllowSyncCountersRateLimitPoliciesBetweenMachinesOutbound-${var.environment}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.NSG2Name

  description                = "Sync Counters for Rate Limit policies between machines"
  protocol                   = "UDP"
  source_port_range          = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_port_ranges    = ["4290"]
  destination_address_prefix = "VirtualNetwork"
  access                     = "Allow"
  priority                   = 1510
  direction                  = "Outbound"
}