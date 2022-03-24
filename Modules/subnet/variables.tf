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

#Virtual Network
variable "vnet_name" {
  description = "The name of the virtual network"
}

#subnets
variable "subnet1CIDR" {
  description = "Network CIDR for subnet1"
}

variable "subnet2CIDR" {
  description = "Network CIDR for subnet2"
}

variable "subnet3CIDR" {
  description = "Network CIDR for subnet3"
}

variable "subnet4CIDR" {
  description = "Network CIDR for subnet4"
}

variable "subnet5CIDR" {
  description = "Network CIDR for subnet5"
}

variable "subnet6CIDR" {
  description = "Network CIDR for subnet6"
}

variable "subnet7CIDR" {
  description = "Network CIDR for subnet7"
}

variable "subnet10CIDR" {
  description = "Network CIDR for subnet10"
}

variable "subnet11CIDR" {
  description = "Network CIDR for subnet11"
}

variable "subnet12CIDR" {
  description = "Network CIDR for subnet12"
}

variable "subnet13CIDR" {
  description = "Network CIDR for subnet13"
}

variable "subnet14CIDR" {
  description = "Network CIDR for subnet14"
}

variable "subnet15CIDR" {
  description = "Network CIDR for subnet15"
}

variable "subnet16CIDR" {
  description = "Network CIDR for subnet16"
}

variable "subnet17CIDR" {
  description = "Network CIDR for subnet17"
}

variable "subnet18CIDR" {
  description = "Network CIDR for subnet18"
}

variable "subnet1Name" {
  description = "Network Name for subnet1"
}

variable "subnet2Name" {
  description = "Network Name for subnet2"
}

variable "subnet3Name" {
  description = "Network Name for subnet3"
}

variable "subnet4Name" {
  description = "Network Name for subnet4"
}

variable "subnet5Name" {
  description = "Network Name for subnet5"
}

variable "subnet6Name" {
  description = "Network Name for subnet6"
}

variable "subnet7Name" {
  description = "Network Name for subnet7"
}

variable "subnet10Name" {
  description = "Network Name for subnet10"
}

variable "subnet11Name" {
  description = "Network Name for subnet11"
}

variable "subnet12Name" {
  description = "Network Name for subnet12"
}

variable "subnet13Name" {
  description = "Network Name for subnet13"
}

variable "subnet14Name" {
  description = "Network Name for subnet14"
}

variable "subnet15Name" {
  description = "Network Name for subnet15"
}

variable "subnet16Name" {
  description = "Network Name for subnet16"
}

variable "subnet17Name" {
  description = "Network Name for subnet17"
}

variable "subnet18Name" {
  description = "Network Name for subnet18"
}