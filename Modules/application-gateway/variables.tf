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
  type        = string
  description = "subnet5 id - application gateway"
}

variable "Public_IP_ID" {
  type        = string
  description = "ID of public IP address for app gateway"
}

variable "AppGatewayName" {
  type        = string
  description = "The name of the app gateway resource being deployed"
}

variable "pdpreact_fqdn" {
  type        = string
  description = "The fqdn of the pdpreact web application"
}

variable "pdpauthproxy_fqdn" {
  type        = string
  description = "The fqdn of the pdpauthproxy web application"
}

variable "pdpexperience_fqdn" {
  type        = string
  description = "The fqdn of the experience api web application"
}

variable "request_body_check" {
  description = "True or false to request_body_check in WAF"
  default     = false
}

variable "CoreResourceGroup" {
  description = "Name of resource group containing core resources"
}

variable "CoreKeyvault" {
  description = "Name of keyvault in core resources"
}