data "azurerm_key_vault" "kv_network_core" {
  name                = var.CoreKeyvault
  resource_group_name = var.CoreResourceGroup
}