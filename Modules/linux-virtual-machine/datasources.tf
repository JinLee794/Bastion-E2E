data "azurerm_key_vault" "Core_KeyVault" {
  name                = var.CoreKeyvault
  resource_group_name = var.CoreResourceGroup
}