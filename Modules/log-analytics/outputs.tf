output "az_law_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "az_law_name" {
  value = azurerm_log_analytics_workspace.law.name
}

output "az_law_psk" {
  value = azurerm_log_analytics_workspace.law.primary_shared_key
}

output "az_workspace_id" {
  value = azurerm_log_analytics_workspace.law.workspace_id
}