# wait after VM is up to deploy the qualys agent to it
resource "time_sleep" "wait" {
  count           = var.BuildBastionInfra ? 1 : 0
  depends_on      = [azurerm_linux_virtual_machine.vm-vm[0]]
  create_duration = "240s"
}

#Security vulnerability assessment
# add qualys agent to VM
resource "azurerm_security_center_server_vulnerability_assessment" "qualys" {
  count              = var.BuildBastionInfra ? 1 : 0
  virtual_machine_id = azurerm_linux_virtual_machine.vm-vm[0].id
  depends_on         = [time_sleep.wait[0]]
}

#user password - not used, pulled from Jenkins secret instead
resource "random_string" "user1_pass" {
  count            = var.BuildBastionInfra ? 1 : 0
  length           = 32
  special          = "true"
  min_special      = 2
  override_special = "*!@#?"
} #generate random to force null resources to trigger every time
resource "random_id" "random" {
  count = var.BuildBastionInfra ? 1 : 0
  keepers = {
    uuid = uuid()
  }
  byte_length = 8
}

#encrypt local disks
resource "null_resource" "EncryptVMDisks" {
  count    = var.BuildBastionInfra ? 1 : 0
  triggers = { random = random_id.random[0].hex }
  provisioner "local-exec" {
    command = "az vm encryption enable -g ${var.resource_group_name} -n $VM_NAME --disk-encryption-keyvault $KEYVAULT_ID --volume-type ALL"
    environment = {
      VM_NAME     = "${var.vm_name}-${var.environment}"
      KEYVAULT_ID = data.azurerm_key_vault.Core_KeyVault.id
    }
  }
  depends_on = [time_sleep.wait[0]]
}

#configure auto-shutdown
resource "null_resource" "Auto-Shutdown" {
  count    = var.BuildBastionInfra ? 1 : 0
  triggers = { random = random_id.random[0].hex }
  provisioner "local-exec" {
    command = "az vm auto-shutdown -g ${var.resource_group_name} --name $VM_NAME --time 23:23"
    environment = {
      VM_NAME = "${var.vm_name}-${var.environment}"
    }
  }
  depends_on = [azurerm_linux_virtual_machine.vm-vm[0]]
}

resource "azurerm_virtual_machine_extension" "mma-dep-lnx" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "DependencyAgentLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-vm[0].id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.10"
  depends_on                 = [time_sleep.wait[0]]
  auto_upgrade_minor_version = true
  settings                   = <<SETTINGS
        {
          "workspaceId": "${var.az_law_id}"
        }
        SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
        {
          "workspaceKey": "${var.az_law_psk}"
        }
        PROTECTED_SETTINGS
}

# vm log analytics
resource "azurerm_virtual_machine_extension" "mma-lnx" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "MicrosoftMonitoringAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-vm[0].id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  depends_on                 = [azurerm_virtual_machine_extension.mma-dep-lnx]
  auto_upgrade_minor_version = true
  settings                   = <<SETTINGS
        {
          "workspaceId": "${var.az_workspace_id}"
        }
        SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
        {
          "workspaceKey": "${var.az_law_psk}"
        }
        PROTECTED_SETTINGS
}

#Guest Configuration extension for Linux
resource "azurerm_virtual_machine_extension" "ConfigurationforLinux" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "AzurePolicyforLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-vm[0].id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationForLinux"
  type_handler_version       = "1.26"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine_extension.mma-dep-lnx]
}