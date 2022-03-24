data "azurerm_key_vault" "kv" {
  name                = var.CoreKeyvault
  resource_group_name = var.CoreResourceGroup
}

data "azurerm_key_vault_certificate" "appgw01-cert-pfx" {
  name         = "appgw01-cert-pfx"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_client_config" "current" {}