output "NSG1" {
  value = azurerm_network_security_group.NSG1
}

output "NSG2" {
  value = azurerm_network_security_group.NSG2
}

output "NSG3" {
  value = azurerm_network_security_group.NSG3
}

output "NSG4" {
  value = azurerm_network_security_group.NSG4
}

output "NSG5" {
  value = azurerm_network_security_group.NSG5
}

output "NSG6" {
  value = azurerm_network_security_group.NSG6
}

output "NSG7" {
  value = azurerm_network_security_group.NSG7
}

output "NSG10" {
  value = azurerm_network_security_group.NSG10
}

output "NSG11" {
  value = azurerm_network_security_group.NSG11
}

output "NSG12" {
  value = azurerm_network_security_group.NSG12
}

output "NSG13" {
  value = azurerm_network_security_group.NSG13
}

output "NSG14" {
  value = azurerm_network_security_group.NSG14
}

output "NSG15" {
  value = azurerm_network_security_group.NSG15
}

output "NSG16" {
  value = azurerm_network_security_group.NSG16
}

output "NSG17" {
  value = azurerm_network_security_group.NSG17
}

output "NSG18" {
  value = azurerm_network_security_group.NSG18
}

output "NSGNames" {
  description = "used for applying common rules"
  value = [
    azurerm_network_security_group.NSG1.name
    , azurerm_network_security_group.NSG2.name
    , azurerm_network_security_group.NSG3.name
    , azurerm_network_security_group.NSG4.name
    , azurerm_network_security_group.NSG6.name
    , azurerm_network_security_group.NSG7.name
    , azurerm_network_security_group.NSG10.name
    , azurerm_network_security_group.NSG11.name
    , azurerm_network_security_group.NSG12.name
    , azurerm_network_security_group.NSG13.name
    , azurerm_network_security_group.NSG14.name
    , azurerm_network_security_group.NSG16.name
    , azurerm_network_security_group.NSG17.name
    , azurerm_network_security_group.NSG18.name
  ]
}
