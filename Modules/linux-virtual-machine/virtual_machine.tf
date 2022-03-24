#NIC for VM
resource "azurerm_network_interface" "vm_nic" {
  count               = var.BuildBastionInfra ? 1 : 0
  name                = "nic-${var.vm_name}-pdp-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "${var.vm_name}-ip-vm-internal"
    subnet_id                     = var.vm-subnet_ID
    private_ip_address_allocation = "dynamic"
  }
}

#vm VM
resource "azurerm_linux_virtual_machine" "vm-vm" {
  count                           = var.BuildBastionInfra ? 1 : 0
  name                            = "${var.vm_name}-${var.environment}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_F4"
  tags                            = var.tags
  provision_vm_agent              = true
  admin_username                  = "${var.vm_admin}-${var.environment}"
  admin_password                  = var.vm_admin_passwd
  computer_name                   = var.vm_name
  disable_password_authentication = false
  allow_extension_operations      = true
  #encryption_at_host_enabled      = true

  network_interface_ids = [
    azurerm_network_interface.vm_nic[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}