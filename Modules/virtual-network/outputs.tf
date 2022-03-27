output "id" {
  value = azurerm_virtual_network.this.id
}

output "name" {
  value = azurerm_virtual_network.this.name
}

# Subnets
output "subnet_ids" {
  value = [for x in azurerm_subnet.this : x.id]
}

output "map_subnet_ids" {
  value = { for x in azurerm_subnet.this : x.name => x.id }
}

output "map_subnets" {
  description = ""
  value       = { for k, b in azurerm_subnet.this : k => { "address_prefixes" = b.address_prefixes, "id" = b.id, "name" = b.name } }
}
