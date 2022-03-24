output "private_ip_address" {
  value = azurerm_network_interface.vm_nic[0].private_ip_address
}

output "vm_id" {
  value = azurerm_windows_virtual_machine.vm-vm[0].id
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.vm-vm[0].name
}