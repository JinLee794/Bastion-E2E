resource "azurerm_public_ip" "Public_IP" {
  name                = var.PublicIPName
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  domain_name_label   = var.PublicDNSName
  tags                = var.tags
}

#AZ Bastion Host service
resource "azurerm_bastion_host" "az-bastion" {
  name                = "azure-bastion-pdp-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "Bastion_IP_configuration"
    subnet_id            = var.subnet_15_ID
    public_ip_address_id = azurerm_public_ip.Public_IP.id
  }
}