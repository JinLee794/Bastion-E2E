#Common
variable "kv_agw_id" {
  type        = string
  description = "The id of the azure keyvault holding the ssl cert"
}

variable "kv-certificate-permissions-full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
  "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"]
}

variable "kv-certificate-permissions-read" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = ["get", "getissuers", "list", "listissuers"]
}