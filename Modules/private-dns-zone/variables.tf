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

variable "vnet_name" {
  description = "The name of the virtual network to create zone in"
}

variable "private_dns_zones" {
  description = "The FQDN of the zone to create"
  type = map
}

variable "registration_enabled" {
  description = "Enable or disable autoregistration of dns records in the zone"
  default     = false
}
