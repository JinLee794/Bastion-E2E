resource "azurerm_private_dns_cname_record" "PrivateDNSCNAME" {
  name                = "${var.CNAME}.${var.DNS_Zone_FQDN}"
  record              = var.CNAME
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  zone_name           = var.DNS_Zone_FQDN
}