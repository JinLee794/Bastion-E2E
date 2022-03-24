resource "azurerm_network_interface" "az-nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ID
    private_ip_address_allocation = "Static"
    private_ip_address            = var.ip_address
    private_ip_address_version    = "IPv4"
  }
}