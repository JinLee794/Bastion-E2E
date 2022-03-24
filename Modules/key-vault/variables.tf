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

variable "kv_name" {
  type        = string
  description = "The name of the azure keyvault holding the ssl cert"
}

variable "subnet14_ID" {
  description = "ID of subnet14"
}

variable "UHG_address_prefixes" {
  description = "list of NSG Names for common rules"
  type        = any
  default     = {}
}