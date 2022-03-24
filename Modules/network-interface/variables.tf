#Common
variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location to deploy resources to."
}

variable "nic_name" {
  description = "The name of the network interface card"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "ip_address" {
  type        = string
  description = "The IPv4 address of the NIC"
}

variable "subnet_ID" {
  description = "ID of subnet5"
}

variable "vnet_id" {
  description = "ID of vnet to link the private endpoint to"
}


variable "private_dns_zone_ids" {
  description = "ID of private DNS zone to link the private endpoint to"
}