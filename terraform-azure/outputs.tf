###############################
##  CONTRACT OUTS            ##
###############################

##############################
##  NETWORK OUTS            ##
##############################
output "pcf_resource_group_name" {
  value = data.azurerm_resource_group.pcf-rg.name
}

##############################
##  GENERAL OUTS            ##
##############################
output "ntp_server" {
  value = var.ntp_server
}
output "syslog_host" {
  value = "${var.syslog_host}"
}
output "syslog_port" {
  value = "${var.syslog_port}"
}
output "smtp_address" {
  value = "${var.smtp_address}"
}
output "smtp_from" {
  value = "${var.smtp_from}"
}
output "recipient_email" {
  value = "${var.recipient_email}"
}
##################
##  OPSMAN OUTS ##
##################
output "saml_idp_metadata" {
  value = var.saml_idp_metadata
}

output "saml_rbac_admin_pcf_resource_group_name" {
  value = var.saml_rbac_admin_pcf_resource_group_name
}

output "saml_rbac_groups_attribute" {
  value = var.saml_rbac_groups_attribute
}

output "decryption_passphrase" {
  sensitive = true
  value     = var.decryption-passphrase
}

output "ops_manager_ssh_public_key" {
  sensitive = true
  value     = module.ops_manager.ops_manager_ssh_public_key
}

output "ops_manager_ssh_private_key" {
  sensitive = true
  value     = module.ops_manager.ops_manager_ssh_private_key
}

output "pcf_spoke_resource_group" {
  value = data.azurerm_virtual_network.pcf-spoke.resource_group_name
}

output "infrastructure_subnet_name" {
  value = data.azurerm_subnet.pcf-infra.name
}

output "infrastructure_subnet_cidrs" {
  value = [data.azurerm_subnet.pcf-infra.address_prefix]
}

output "infrastructure_subnet_gateway" {
  value = cidrhost(data.azurerm_subnet.pcf-infra.address_prefix, 1)
}

output "pas_subnet_name" {
  value = data.azurerm_subnet.pcf-depl.name
}

output "pas_subnet_cidrs" {
  value = [data.azurerm_subnet.pcf-depl.address_prefix]
}

output "pas_subnet_gateway" {
  value = cidrhost(data.azurerm_subnet.pcf-depl.address_prefix, 1)
}

output "services_subnet_name" {
  value = data.azurerm_subnet.pcf-svcs.name
}
output "client_id" {
    sensitive = true
    value = "${var.client_id}"
}
output "client_secret" {
    sensitive = true
    value = "${var.client_secret}"
}
output "subscription_id" {
    sensitive = true
    value = "${var.subscription_id}"
}
output "tenant_id" {
    sensitive = true
    value = "${var.subscription_id}"
}
output "services_subnet_cidrs" {
  value = [data.azurerm_subnet.pcf-svcs.address_prefix]
}

output "services_subnet_gateway" {
  value = cidrhost(data.azurerm_subnet.pcf-svcs.address_prefix, 1)
}

output "pks_subnet_name" {
  value = "pks-services"
}

output "pks_subnet_cidrs" {
  value = [data.azurerm_subnet.pcf-pks.address_prefix]
}

output "pks_subnet_gateway" {
  value = cidrhost(data.azurerm_subnet.pcf-pks.address_prefix, 1)
}

output "dns_server" {
  value = var.dns_server
}

output "network_name" {
  value = data.azurerm_virtual_network.pcf-spoke.name
}

# ########################
# #      Director OUTS   #
# ########################
output "director_hostname" {
  value = var.director_hostname
}
output "bosh_root_storage_account" {
  value = "${module.infra.bosh_root_storage_account}"
}
output "trusted_certs" {
  sensitive = true
  value     = "${var.ssl_cert}"
}
###############
##  PAS OUTS ##
###############
output "saml_display_name" {
  value = "${var.saml_display_name}"
}
output "pas_saml_sso_url" {
  value = "${var.pas_saml_sso_url}"
}
output "apps_manager_company_name" {
  value = "${var.apps_manager_company_name}"
}
output "push_apps_manager_logo" {
  value = "${var.push_apps_manager_logo}"
}
output "push_apps_manager_square_logo" {
  value = "${var.push_apps_manager_square_logo}"
}
output "push_apps_manager_favicon" {
  value = "${var.push_apps_manager_favicon}"
}
output "credhub_encrypt_key" {
  sensitive = true
  value = "${var.credhub_encrypt_key}"
}
output "mysql_monitor_recipient_email" {
  value = "${var.mysql_monitor_recipient_email}"
}
output "push_apps_manager_footer_text" {
  value = "${var.push_apps_manager_footer_text}"
}
output "web_lb_name" {
  value = "${module.pas.web_lb_name}"
}
output "diego_ssh_lb_name" {
  value = "${module.pas.diego_ssh_lb_name}"
}
output "mysql_lb_name" {
  value = "${module.pas.mysql_lb_name}"
}
output "tcp_lb_name" {
  value = "${module.pas.tcp_lb_name}"
}
output "sys_domain" {
  value = "sys.${var.dns_suffix}"
}
output "apps_domain" {
  value = "apps.${var.dns_suffix}"
}
output "cf_storage_account_access_key" {
  sensitive = true
  value     = "${module.pas.cf_storage_account_access_key}"
}
output "cf_droplets_storage_container" {
  value = "${module.pas.cf_droplets_storage_container_name}"
}
output "cf_packages_storage_container" {
  value = "${module.pas.cf_packages_storage_container_name}"
}
output "cf_resources_storage_container" {
  value = "${module.pas.cf_resources_storage_container_name}"
}
output "cf_buildpacks_storage_container" {
  value = "${module.pas.cf_buildpacks_storage_container_name}"
}
output "cf_storage_account_name" {
  value = "${module.pas.cf_storage_account_name}"
}
################
##  PASW OUTS ##
################
output "windows_password" {
    sensitive = true
    value = "${var.windows_password}"
}
output "numberOfWinCells" {
    value = "${var.numberOfWinCells}"
}
#################
##  REDIS OUTS ##
#################
output "redis_backup_account" {
  value = "${var.redis_backup_account}"
}
output "redis_backup_container" {
  value = "${var.redis_backup_container}"
}
output "redis_backup_path" {
  value = "${var.redis_backup_path}"
}

#######################
##  HEALTHWATCH OUTS ##
#######################
output "healthwatch_uaa_user" {
  value = "${var.healthwatch_uaa_user}"
}

output "healthwatch_uaa_password" {
  sensitive = true
  value = "${var.healthwatch_uaa_password}"
}

output "opsman_url" {
  value = "${var.opsman_url}"
}

output "foundation_name" {
  value = "${var.foundation_name}"
}

################
#Azure sb
################
output "azsb_db_server" {
    value = "${var.azsb_db_server}"
}
output "azsb_db_encryption_key" {
    value = "${var.azsb_db_encryption_key}"
    sensitive = true
}
output "azsb_db_name" {
    value = "${var.azsb_db_name}"
}
output "azsb_db_password" {
    value = "${var.azsb_db_password}"
    sensitive = true
}
output "azsb_db_user" {
    value = "${var.azsb_db_user}"
}

##################
##  HARBOR OUTS ##
##################
output "harbor_static_ip" {
  value       = "${var.harbor_static_ip}"
}

output "harbor_hostname" {
  value       = "${var.harbor_hostname}"
}

output "harbor_admin_password" {
  sensitive = true
  value = "${var.harbor_admin_password}"
}

output "harbor_admin_password_for_smoketest" {
  sensitive = true
  value = "${var.harbor_admin_password_for_smoketest}"
}

output "harbor_lb_name" {
  value = "${module.harbor.harbor_lb_name}"
}

#################
##  MySQL OUTS ##
#################
output "mysql_backup_path" {
  value = "${var.mysql_backup_path}"
}
output "mysql_backup_container" {
  value = "${var.mysql_backup_container}"
}
output "mysql_subnet_name" {
  value = "${var.mysql_subnet_name}"
}
output "mysql_backup_email" {
  value = "${var.mysql_backup_email}"
}
output "mysql_backup_account" {
  value = "${var.mysql_backup_account}"
}
output "storage_access_key" {
  sensitive = true
  value = "${var.storage_access_key}"
}
##########################
#        SSL KEYS        #
##########################
output "ssl_cert" {
  sensitive = true
  value     = var.ssl_cert
}

output "ssl_private_key" {
  sensitive = true
  value     = var.ssl_private_key
}

