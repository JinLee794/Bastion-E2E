variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location to deploy resources to."
}

variable "environment" {
  description = "The build environment resources are being deployed in."
  default     = "dev"
}

#NSG Names
variable "NSG1Name" {
  description = "Network Security Group Name for NSG1"
}

variable "NSG2Name" {
  description = "Network Security Group Name for NSG2"
}

variable "NSG3Name" {
  description = "Network Security Group Name for NSG3"
}

variable "NSG4Name" {
  description = "Network Security Group Name for NSG4"
}

variable "NSG5Name" {
  description = "Network Security Group Name for NSG5"
}

variable "NSG6Name" {
  description = "Network Security Group Name for NSG6"
}

variable "NSG7Name" {
  description = "Network Security Group Name for NSG7"
}

variable "NSG10Name" {
  description = "Network Security Group Name for NSG10"
}

variable "NSG11Name" {
  description = "Network Security Group Name for NSG11"
}

variable "NSG12Name" {
  description = "Network Security Group Name for NSG12"
}

variable "NSG13Name" {
  description = "Network Security Group Name for NSG12"
}

variable "NSG14Name" {
  description = "Network Security Group Name for NSG14"
}

variable "NSG15Name" {
  description = "Network Security Group Name for NSG15"
}

variable "NSG16Name" {
  description = "Network Security Group Name for NSG16"
}

variable "NSG17Name" {
  description = "Network Security Group Name for NSG17"
}

variable "NSG18Name" {
  description = "Network Security Group Name for NSG18"
}

#subnets
variable "subnet1CIDR" {
  description = "Network CIDR for subnet1"
  default     = "10.50.1.0/24"
}

variable "subnet2CIDR" {
  description = "Network CIDR for subnet2"
  default     = "10.50.2.0/24"
}

variable "subnet3CIDR" {
  description = "Network CIDR for subnet3"
  default     = "10.50.3.0/24"
}

variable "subnet4CIDR" {
  description = "Network CIDR for subnet4"
  default     = "10.50.4.0/24"
}

variable "subnet5CIDR" {
  description = "Network CIDR for subnet5"
  default     = "10.50.5.0/24"
}

variable "subnet6CIDR" {
  description = "Network CIDR for subnet6"
  default     = "10.50.6.0/24"
}

variable "subnet7CIDR" {
  description = "Network CIDR for subnet7"
  default     = "10.50.7.0/24"
}

variable "subnet10CIDR" {
  description = "Network CIDR for subnet10"
  default     = "10.50.10.0/24"
}

variable "subnet11CIDR" {
  description = "Network CIDR for subnet11"
  default     = "10.50.11.0/24"
}

variable "subnet12CIDR" {
  description = "Network CIDR for subnet12"
  default     = "10.50.12.0/24"
}

variable "subnet13CIDR" {
  description = "Network CIDR for subnet13"
  default     = "10.50.13.0/24"
}

variable "subnet14CIDR" {
  description = "Network CIDR for subnet14"
  default     = "10.50.14.0/24"
}

variable "subnet15CIDR" {
  description = "Network CIDR for subnet15"
  default     = "10.50.15.0/24"
}

variable "subnet16CIDR" {
  description = "Network CIDR for subnet16"
  default     = "10.50.16.0/24"
}

variable "subnet17CIDR" {
  description = "Network CIDR for subnet17"
  default     = "10.50.17.0/24"
}

variable "subnet18CIDR" {
  description = "Network CIDR for subnet18"
  default     = "10.50.18.0/24"
}

variable "NSGNames" {
  description = "list of NSG Names for common rules"
  type        = any
  default     = {}
}

variable "UHG_address_prefixes" {
  description = "list of NSG Names for common rules"
  type        = any
  default     = {}
}

variable "vnet_CIDR" {
  description = "Network CIDR for vnet"
  default     = "10.50.0.0/16"
}