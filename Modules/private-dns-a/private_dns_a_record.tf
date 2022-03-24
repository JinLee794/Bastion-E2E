resource "azurerm_private_dns_a_record" "DNSARecord" {
  name                = var.dns_name
  records             = [var.dns_record]
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  zone_name           = var.DNS_Zone_FQDN
}