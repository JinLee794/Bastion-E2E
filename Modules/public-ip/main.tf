resource "azurerm_public_ip" "Public_IP" {
  name                = var.PublicIPName
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  domain_name_label   = var.PublicDNSName
  tags                = var.tags
}