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
variable "vnet_name" {
  description = "The name of the virtual network"
}

variable "vnet_CIDR" {
  description = "The CIDR of the virtual network"
}

variable "dns_servers" {
  description = "The DNS servers for the virtual network"
}
variable "CoreResourceGroup" {
  description = "Name of resource group containing core resources"
}

variable "DDoSPlanName" {
  description = "Name of DDoS plan for this vnet"
}