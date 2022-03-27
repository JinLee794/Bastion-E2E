#Common
variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location to deploy resources to."
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

#Virtual Network
variable "name" {
  description = "The name of the virtual network"
}

variable "address_space" {
  description = "The CIDR of the virtual network"
  type = list(string)
}

variable "dns_servers" {
  description = "The DNS servers for the virtual network"
  default = []
}

variable "subnets" {
  description = "The DNS servers for the virtual network"
  type = map
}


// variable "CoreResourceGroup" {
//   description = "Name of resource group containing core resources"
// }

// variable "DDoSPlanName" {
//   description = "Name of DDoS plan for this vnet"
// }
