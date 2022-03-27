locals {
  layer_name = "bastion-network"


  KeyVaultPrivLinkSubnet_NSGRules = [
    {
      "name" : "AllowBastionInbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 2010,
      "direction" : "Inbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443"
      ]
    },
    {
      "name" : "AllowAzureMonitorOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 1503,
      "direction" : "Outbound",
      "destination_address_prefix" : "AzureMonitor",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "1886",
        "443"
      ]
    }
  ]
  AzureBastionSubnet_NSGRules = [
    {
      "name" : "AllowGatewayManagerInbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "GatewayManager",
      "access" : "Allow",
      "priority" : 130,
      "direction" : "Inbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443"
      ]
    },
    {
      "name" : "AllowAzureLoadBalancerInbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "AzureLoadBalancer",
      "access" : "Allow",
      "priority" : 140,
      "direction" : "Inbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443"
      ]
    },
    {
      "name" : "AllowBastionHostCommunication",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 150,
      "direction" : "Inbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "8080",
        "5701"
      ]
    },
    {
      "name" : "AllowHTTPSInbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "Internet",
      "access" : "Allow",
      "priority" : 120,
      "direction" : "Inbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443"
      ]
    },
    {
      "name" : "AllowSshRdpOutbound",
      "description" : "",
      "protocol" : "*",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "*",
      "access" : "Allow",
      "priority" : 100,
      "direction" : "Outbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "22",
        "3389"
      ]
    },
    {
      "name" : "AllowBastionCommunication",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 120,
      "direction" : "Outbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "8080",
        "5701"
      ]
    },
    {
      "name" : "AllowGetSessionInformation",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "Internet",
      "access" : "Allow",
      "priority" : 130,
      "direction" : "Outbound",
      "destination_address_prefix" : "Internet",
      "destination_port_range" : "*",
      "destination_port_ranges" : []
    },
    {
      "name" : "AllowAzureMonitorOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 1503,
      "direction" : "Outbound",
      "destination_address_prefix" : "AzureMonitor",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "1886",
        "443"
      ]
    }
  ]
  BastionVMSubnet_NSGRules = [
    {
      "name" : "AllowSSHRDPFromBastionInbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "GatewayManager",
      "access" : "Allow",
      "priority" : 100,
      "direction" : "Inbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : null,
      "destination_port_ranges" : ["22", "3389"]
    },
    {
      "name" : "SynapseWorkspaceOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 2000,
      "direction" : "Inbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443",
        "1433"
      ]
    },
    {
      "name" : "RedisOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 2222,
      "direction" : "Outbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "6380"
      ]
    },
    {
      "name" : "InternetOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "GatewayManager",
      "access" : "Allow",
      "priority" : 2233,
      "direction" : "Outbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443",
        "80"
      ]
    },
    {
      "name" : "AllowAzureMonitorOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 1503,
      "direction" : "Outbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "1886",
        "443"
      ]
    }
  ]
  Common_NSGRules = [
    {
      "name" : "DenyAllInboundTraffic",
      "description" : "",
      "protocol" : "*",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "*",
      "access" : "Deny",
      "priority" : 4003,
      "direction" : "Inbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : "*",
      "destination_port_ranges" : []
    },
    {
      "name" : "AllowVNetInbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 4000,
      "direction" : "Inbound",
      "destination_address_prefix" : "VirtualNetwork",
      "destination_port_range" : "*",
      "destination_port_ranges" : []
    },
    {
      "name" : "AllowVNetOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "*",
      "access" : "Allow",
      "priority" : 4001,
      "direction" : "Outbound",
      "destination_address_prefix" : "*",
      "destination_port_range" : "*",
      "destination_port_ranges" : []
    },
    {
      "name" : "AllowAzureCloudOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "VirtualNetwork",
      "access" : "Allow",
      "priority" : 4002,
      "direction" : "Outbound",
      "destination_address_prefix" : "AzureCloud",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "443",
        "9000"
      ]
    },
    {
      "name" : "AllowAzureDNSOutbound",
      "description" : "",
      "protocol" : "Tcp",
      "source_port_range" : "*",
      "source_port_ranges" : null,
      "source_address_prefix" : "*",
      "access" : "Allow",
      "priority" : 4003,
      "direction" : "Outbound",
      "destination_address_prefix" : "AzureCloud",
      "destination_port_range" : null,
      "destination_port_ranges" : [
        "53"
      ]
    }
  ]
}
