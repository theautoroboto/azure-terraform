#Can't register DNS here.  Must be manual in domain.com
# resource "azurerm_dns_a_record" "pks" {
#   name                = "*.pks"
#   zone_name           = "${var.dns_suffix}"
#   resource_group_name = "${var.pcf_resource_group_name}"
#   ttl                 = "60"
#   records             = ["${var.pcf_pks_public_ip_address}"]
# }