output "private_ip_address" {
  value = azurerm_network_interface.vm_nic[0].private_ip_address
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm-vm[0].id
}