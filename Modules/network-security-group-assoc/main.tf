#NSG1 <-> subnet1
resource "azurerm_subnet_network_security_group_association" "NSG1Link" {
  subnet_id                 = var.subnet1_ID
  network_security_group_id = var.NSG1_ID
}

#NSG2 <-> subnet2
resource "azurerm_subnet_network_security_group_association" "NSG2Link" {
  subnet_id                 = var.subnet2_ID
  network_security_group_id = var.NSG2_ID
}

#NSG3 <-> subnet3
resource "azurerm_subnet_network_security_group_association" "NSG3Link" {
  subnet_id                 = var.subnet3_ID
  network_security_group_id = var.NSG3_ID
}

#NSG4 <-> subnet4
resource "azurerm_subnet_network_security_group_association" "NSG4Link" {
  subnet_id                 = var.subnet4_ID
  network_security_group_id = var.NSG4_ID
}

#NSG5 <-> subnet5
resource "azurerm_subnet_network_security_group_association" "NSG5Link" {
  subnet_id                 = var.subnet5_ID
  network_security_group_id = var.NSG5_ID
}

#NSG6 <-> subnet6
resource "azurerm_subnet_network_security_group_association" "NSG6Link" {
  subnet_id                 = var.subnet6_ID
  network_security_group_id = var.NSG6_ID
}

#NSG7 <-> subnet7
resource "azurerm_subnet_network_security_group_association" "NSG7Link" {
  subnet_id                 = var.subnet7_ID
  network_security_group_id = var.NSG7_ID
}

#NSG10 <-> subnet10
resource "azurerm_subnet_network_security_group_association" "NSG10Link" {
  subnet_id                 = var.subnet10_ID
  network_security_group_id = var.NSG10_ID
}

#NSG11 <-> subnet11
resource "azurerm_subnet_network_security_group_association" "NSG11Link" {
  subnet_id                 = var.subnet11_ID
  network_security_group_id = var.NSG11_ID
}

#NSG12 <-> subnet12
resource "azurerm_subnet_network_security_group_association" "NSG12Link" {
  subnet_id                 = var.subnet12_ID
  network_security_group_id = var.NSG12_ID
}

#NSG13 <-> subnet13
resource "azurerm_subnet_network_security_group_association" "NSG13Link" {
  subnet_id                 = var.subnet13_ID
  network_security_group_id = var.NSG13_ID
}

#NSG14 <-> subnet14
resource "azurerm_subnet_network_security_group_association" "NSG14Link" {
  subnet_id                 = var.subnet14_ID
  network_security_group_id = var.NSG14_ID
}

#NSG15 <-> subnet15
resource "azurerm_subnet_network_security_group_association" "NSG15Link" {
  subnet_id                 = var.subnet15_ID
  network_security_group_id = var.NSG15_ID
}

#NSG16 <-> subnet16
resource "azurerm_subnet_network_security_group_association" "NSG16Link" {
  subnet_id                 = var.subnet16_ID
  network_security_group_id = var.NSG16_ID
}

#NSG17 <-> subnet17
resource "azurerm_subnet_network_security_group_association" "NSG17Link" {
  subnet_id                 = var.subnet17_ID
  network_security_group_id = var.NSG17_ID
}

#NSG18 <-> subnet18
resource "azurerm_subnet_network_security_group_association" "NSG18Link" {
  subnet_id                 = var.subnet18_ID
  network_security_group_id = var.NSG18_ID
}