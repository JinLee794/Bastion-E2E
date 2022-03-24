variable "CNAME" {
  description = "CNAME to be registered in private DNS zone."
}

variable "DNS_Zone_FQDN" {
  description = "FQDN of private DNS zone to create records in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location to deploy resources to."
}

variable "environment" {
  description = "The name of the environment that is being deployed"
}

variable "project_name" {
  description = "The name of the project which will become the DNS zone."
}

variable "ttl" {
  description = "The time to live of the DNS record."
  default     = "3600"
}