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

variable "PublicIPName" {
  description = "The name of the PublicIPName resource being deployed"
}

variable "PublicDNSName" {
  description = "The Public DNS Name being created"
}