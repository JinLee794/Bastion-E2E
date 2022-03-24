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

variable "subnet_15_ID" {
  description = "ID of Bastion Service subnet"
}

variable "PublicIPName" {
  description = "The name of the PublicIPName resource being deployed"
}

variable "PublicDNSName" {
  description = "The Public DNS Name being created"
}