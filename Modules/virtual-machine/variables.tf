#Common
variable "resource_group_name" {
  description = "The name of the resource group the vm's will be in."
}

variable "resource_group_name_components" {
  description = "resource group for secondary vm components"
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

variable "vm-subnet_ID" {
  description = "ID of vm VM subnet"
}

variable "vm_admin" {
  description = "Admin account name for vm"
}

variable "vm_name" {
  description = "name for vm"
}

variable "vm_admin_passwd" {
  description = "Admin account name for vm"
}

variable "az_law_id" {
  description = "ID of azure log analytics workspace"
}

variable "az_law_psk" {
  description = "Primary shared key of azure log analytics workspace"
}

variable "az_workspace_id" {
  description = "workspace_id of azure log analytics workspace"
}

variable "CoreKeyvault" {
  description = "Name of common keyvault in core infra"
}

variable "CoreResourceGroup" {
  description = "resource group for common network components"
}

variable "BuildBastionInfra" {
  description = "determines if the bastion service & VM's get built/modified"
}

variable "bastion_automation_name" {
  description = "Name of Automation account the various bastion updates service & VM's will use"
}