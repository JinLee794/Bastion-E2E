variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the NSGs."
}

variable "location" {
  type        = string
  description = "The name of the resource group in which to create the NSGs."
}

variable "nsg_additional_tags" {
  type        = map(string)
  description = "Additional Network Security Group resources tags, in addition to the resource group tags."
  default     = {}
}

# -
# - Network Security Group object
# -
variable "network_security_groups" {
  type = map(object({
    name                      = string
    tags                      = map(string)
    subnet_id                  = string
    networking_resource_group = string
    security_rules = list(object({
      name                                         = string
      description                                  = string
      protocol                                     = string
      direction                                    = string
      access                                       = string
      priority                                     = number
      source_address_prefix                        = string
      destination_address_prefix                   = string
      source_port_range                            = string
      source_port_ranges                           = list(string)
      destination_port_range                       = string
      destination_port_ranges                      = list(string)
    }))
  }))
  description = "The network security groups with their properties."
  default     = {}
}

############################
# State File
############################
variable ackey {
  description = "Not required if MSI is used to authenticate to the SA where state file is"
  default     = null
}
