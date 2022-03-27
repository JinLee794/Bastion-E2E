# wait after VM is up to deploy the qualys agent to it
// resource "time_sleep" "wait" {
//   count           = var.BuildBastionInfra ? 1 : 0
//   depends_on      = [azurerm_windows_virtual_machine.this[0]]
//   create_duration = "360s"
// }

## 1
#Guest Configuration extension for Windows
resource "azurerm_virtual_machine_extension" "ConfigurationforWindows" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "AzurePolicyforWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[0].id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.29"
  auto_upgrade_minor_version = true
  // depends_on                 = [time_sleep.wait[0]]
  timeouts {
    create = "90m"
    delete = "90m"
  }
}

## 2
#Security vulnerability assessment
# add qualys agent to VM
// Jin - Disabling for now as my subsciprtion does not have the enhanced-security plan
// resource "azurerm_security_center_server_vulnerability_assessment" "qualys" {
//   count              = var.BuildBastionInfra ? 1 : 0
//   virtual_machine_id = azurerm_windows_virtual_machine.this[0].id
//   depends_on         = [azurerm_virtual_machine_extension.ConfigurationforWindows]
//   timeouts {
//     create = "90m"
//     delete = "90m"
//   }
// }

// #generate random to force null resources to trigger every time
// resource "random_id" "random" {
//   count = var.BuildBastionInfra ? 1 : 0
//   keepers = {
//     uuid = uuid()
//   }
//   byte_length = 8
// }

## 3
#vm anti-malware
resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "Microsoft.Azure.Security.IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[0].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  // depends_on                 = [azurerm_security_center_server_vulnerability_assessment.qualys[0]]
  auto_upgrade_minor_version = true
  timeouts {
    create = "90m"
    delete = "90m"
  }
}

## 4
#Microsoft Azure Monitoring DependencyAgent
resource "azurerm_virtual_machine_extension" "mma-dep-win" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "DependencyAgentWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[0].id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.10"
  depends_on                 = [azurerm_virtual_machine_extension.antimalware[0]]
  auto_upgrade_minor_version = true
  timeouts {
    create = "90m"
    delete = "90m"
  }
  settings = <<SETTINGS
        {
          "workspaceId": "${var.az_law_id}"
        }
        SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
        {
          "workspaceKey": "${data.azurerm_key_vault_secret.law-win-agent-key.value}"

        }
        PROTECTED_SETTINGS
}

## 5
# vm log analytics
resource "azurerm_virtual_machine_extension" "mma-win" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "MicrosoftMonitoringAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[0].id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  depends_on                 = [azurerm_virtual_machine_extension.mma-dep-win[0]]
  auto_upgrade_minor_version = true
  timeouts {
    create = "90m"
    delete = "90m"
  }
  settings = <<SETTINGS
        {
          "workspaceId": "${var.az_workspace_id}"
        }
        SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
        {
          "workspaceKey": "${data.azurerm_key_vault_secret.law-win-agent-key.value}"

        }
        PROTECTED_SETTINGS
}

## 6
#resource "azurerm_virtual_machine_extension" "SecurePostDeployment" {
#  count                = var.BuildBastionInfra ? 1 : 0
#  name                 = "PostDeploySecurityScript"
#  virtual_machine_id   = azurerm_windows_virtual_machine.this[0].id
#  publisher            = "Microsoft.Compute"
#  type                 = "CustomScriptExtension"
#  type_handler_version = "1.9"
#  depends_on           = [azurerm_virtual_machine_extension.ConfigurationforWindows[0]]
#  timeouts {
#    create = "90m"
#    delete = "90m"
#  }
#  settings = <<SETTINGS
#  {
#    "fileUris": [
#      "https://raw.githubusercontent.com/cx-this-is-a-place-holder/Azure-postdeploy-vm/main/short_az_bastion_secure.ps1"
#    ],
#    "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File short_az_bastion_secure.ps1"
#  }
#  SETTINGS
#}

## 7
#encrypt local disks - often takes longer than 90 minutes so hits Azure time out
#resource "null_resource" "EncryptVMDisks" {
#  count    = var.BuildBastionInfra ? 1 : 0
#  triggers = { random = random_id.random[0].hex }
#  provisioner "local-exec" {
#    command = "az vm encryption enable -g ${var.resource_group_name} -n $VM_NAME --disk-encryption-keyvault $KEYVAULT_ID --volume-type ALL --force"
#    environment = {
#      VM_NAME     = "${var.vm_name}-${var.environment}"
#      KEYVAULT_ID = data.azurerm_key_vault.Core_KeyVault.id
#    }
#  }
#  depends_on = [azurerm_virtual_machine_extension.mma-win[0]]
#}

## 8
#configure auto-shutdown
#resource "null_resource" "Auto-Shutdown" {
#  count    = var.BuildBastionInfra ? 1 : 0
#  triggers = { random = random_id.random[0].hex }
#  provisioner "local-exec" {
#    command = "az vm auto-shutdown -g ${var.resource_group_name} --name $VM_NAME --time 23:23"
#    environment = {
#      VM_NAME = "${var.vm_name}-${var.environment}"
#    }
#  }
#  depends_on = [azurerm_windows_virtual_machine.this[0]]
#}

## 9
##Azure Network Watcher extension for Windows
resource "azurerm_virtual_machine_extension" "NWforWindows" {
  count                      = var.BuildBastionInfra ? 1 : 0
  name                       = "AzureNetworkWatcherforWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[0].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentWindows"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine_extension.mma-win[0]]
  timeouts {
    create = "90m"
    delete = "90m"
  }
}

#install default software - waaaay to long - will hit Azure 90 minute time out
# resource "azurerm_virtual_machine_extension" "SoftwarePostDeployment" {
#   count                = var.BuildBastionInfra ? 1 : 0
#   name                 = "PostDeploySoftwareScript"
#   virtual_machine_id   = azurerm_windows_virtual_machine.this[0].id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.9"
#   depends_on           = [azurerm_virtual_machine_extension.ConfigurationforWindows[0]]
#   "settings": {
#     "fileUris": [
#       "https://raw.githubusercontent.com/cx-this-is-a-place-holder/Azure-postdeploy-vm/main/Bastion-SW-Install.ps1"
#     ],
#     "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File Bastion-SW-Install.ps1 �Noninteractive �Noprofile"
#   }
# }

#user password - not used, pulled from Jenkins secret instead
#resource "random_string" "user1_pass" {
#  count            = var.BuildBastionInfra ? 1 : 0
#  length           = 32
#  special          = "true"
#  min_special      = 2
#  override_special = "*!@#?"
#}
