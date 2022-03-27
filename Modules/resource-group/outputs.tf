output "resource_group" {
  value = azurerm_resource_group.this
}

output "id" {
  value = azurerm_resource_group.this.id
}

output "name" {
  value = regex("/resourceGroups/([a-zA-Z0-9-]+)", azurerm_resource_group.this.id)[0]
}
