##############################
##  <CONTRACTS>             ##
##  These are items which   ##
##  we are fully dependent  ##
##  upon and represent an   ##
##  agreement set forth     ##
##  with a 'provider.'      ##
##############################

subscription_id = ""
tenant_id       = ""
client_id       = ""
client_secret   = ""

#Network
env_name                 = ""
pcf_resource_group_name  = ""
pcf_spoke_resource_group = ""
pcf_spoke_vnet           = ""
pcf_infra_name           = ""
pcf_svcs_name            = ""
pcf_depl_name            = ""
pcf_pks_name             = ""
pcf_boshdepl_name        = ""
pcf_lb_subnet            = ""

##############################
##  GENERAL VARS            ##
##############################
location        = ""
dns_suffix      = ""
dns_subdomain   = ""
env_short_name  = ""
smtp_address    = ""
smtp_from       = ""
recipient_email = ""
ntp_server      = ""
dns_server      = ""

#syslog
syslog_host = ""
syslog_port = "514"

################
#    OpsMan    #
################
# We could use a local source image here instead of the URL!
ops_manager_image_uri = "https://opsmanagereastus.blob.core.windows.net/images/ops-manager-2.7.9-build.240.vhd"
saml_idp_metadata     = ""

saml_rbac_admin_pcf_resource_group_name = ""
saml_rbac_groups_attribute              = "http://schemas.microsoft.com/ws/2008/06/identity/claims/groups"
decryption-passphrase                   = ""
director_hostname                       = ""


###############
##  PAS VARS ##
###############
# pcf_infrastructure_subnet               = ""
web_lb_priv_ip                = ""
diego_lb_priv_ip              = ""
mysql_lb_priv_ip              = ""
tcp_lb_priv_ip                = ""
cf_storage_account_name       = ""
credhub_encrypt_key           = ""
mysql_monitor_recipient_email = ""
apps_manager_company_name     = ""
push_apps_manager_favicon     = ""
push_apps_manager_logo        = ""
push_apps_manager_square_logo = ""
# SAML ONLY
saml_display_name             = ""
pas_saml_sso_url              = ""
push_apps_manager_footer_text = "PaaS 2019"
rg_keyvault                   = ""


################
##  PASW VARS ##
################
numberOfWinCells = 10
password         = ""

#######################
##  HEALTHWATCH VARS ##
#######################
healthwatch_uaa_user     = ""
healthwatch_uaa_password = ""
opsman_url               = ""
foundation_name          = ""

################
#Azure sb
################
azsb_db_server         = ""
azsb_db_encryption_key = ""
azsb_db_name           = ""
azsb_db_password       = ""
azsb_db_user           = ""



#################
##  redis VARS ##
#################
redis_backup_account   = ""
redis_backup_container = ""
redis_backup_path      = ""
storage_access_key     = ""

################
#Harbor
################
harbor_static_ip                    = ""
harbor_hostname                     = ""
harbor_admin_password               = ""
harbor_admin_password_for_smoketest = ""
harbor_lb_priv_ip                   = ""

#################
##  MySQL VARS ##
#################
mysql_backup_account                    = ""
mysql_backup_container                  = ""
mysql_backup_path                       = ""
mysql_subnet_name                       = ""
mysql_backup_email                      = ""

##########################
#        SSL KEYS        #
##########################
ssl_cert = <<SSL_CERT
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
SSL_CERT

ssl_private_key = <<SSL_KEY
-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----
SSL_KEY

trusted_certs = <<SSL_CERT
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
SSL_CERT
