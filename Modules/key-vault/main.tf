#created based on https://vanguard.optum.com/docs/patterns/security/venafi-key-vault/
resource "azurerm_key_vault" "keyvault01" {
  name                            = "${var.kv_name}-${var.environment}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  tags                            = var.tags
  sku_name                        = "standard"
  enabled_for_deployment          = "true"
  enabled_for_disk_encryption     = "true"
  enabled_for_template_deployment = "true"

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.subnet14_ID]
    ip_rules                   = var.UHG_address_prefixes
  }
}