variable "DNS_Zone_FQDN" {
  description = "FQDN of private DNS zone to create records in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "dns_name" {
  description = "The name of the A record entry."
}

variable "dns_record" {
  description = "The IP address of the A record entry."
}

variable "ttl" {
  description = "The time to live of the DNS record."
  default     = "3600"
}