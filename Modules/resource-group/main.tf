resource "azurerm_resource_group" "ResourceGroup" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}