resource "azurerm_key_vault_access_policy" "kv-ap-01" {

  key_vault_id = var.kv_agw_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  certificate_permissions = var.kv-certificate-permissions-full

}