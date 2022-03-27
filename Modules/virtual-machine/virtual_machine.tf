data "azurerm_key_vault" "this" {
  name                = var.law_key_vault_name
  resource_group_name = var.law_key_vault_rg_name
}

data "azurerm_key_vault_secret" "law-win-agent-key" {
  name         = var.law_key_name
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = var.admin_password_secret_name
  key_vault_id = data.azurerm_key_vault.this.id
}

#NIC for VM
resource "azurerm_network_interface" "vm_nic" {
  count               = var.BuildBastionInfra ? 1 : 0
  name                = "nic-${var.vm_name}-pdp-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name_components
  tags                = var.tags

  ip_configuration {
    name                          = "${var.vm_name}-${var.environment}-ip-vm-internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

#vm VM
resource "azurerm_windows_virtual_machine" "this" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "${var.vm_name}-${var.environment}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  size                       = "Standard_F4"
  tags                       = var.tags
  timezone                   = "GMT Standard Time"
  enable_automatic_updates   = true
  patch_mode                 = "AutomaticByOS"
  provision_vm_agent         = true
  admin_username             = var.admin_username
  admin_password             = data.azurerm_key_vault_secret.admin_password.value
  computer_name              = var.vm_name
  allow_extension_operations = true
  network_interface_ids = [
    azurerm_network_interface.vm_nic[0].id,
  ]
  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  timeouts {
    create = "90m"
    delete = "90m"
  }
}

#patch vm's
#resource "azurerm_automation_job_schedule" "patch_schedule" {
#  count                   = var.BuildBastionInfra ? 1 : 0
#  resource_group_name     = var.resource_group_name_components
#  automation_account_name = var.bastion_automation_name
#  schedule_name           = "Install Windows Updates on bastion ${azurerm_windows_virtual_machine.this[0].name}"
#  runbook_name            = "Patch-MicrosoftOMSComputers"

#  parameters = {
#    resourcegroup = var.resource_group_name
#    vmname        = azurerm_windows_virtual_machine.this[0].name
#  }
#}
