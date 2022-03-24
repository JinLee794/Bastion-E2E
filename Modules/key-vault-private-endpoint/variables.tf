#Common
variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location to deploy resources to."
}

variable "environment" {
  description = "The name of the environment that is being deployed"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "subnet5_ID" {
  description = "ID of subnet5"
}

variable "vnet_id" {
  description = "ID of vnet to link the private endpoint to"
}


variable "private_dns_zone_ids" {
  description = "ID of private DNS zone to link the private endpoint to"
}

variable "CoreResourceGroup" {
  description = "Name of resource group containing core resources"
}

variable "CoreKeyvault" {
  description = "Name of keyvault in core resources"
}