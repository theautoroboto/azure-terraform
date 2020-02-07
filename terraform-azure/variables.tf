###############################
##  CONTRACT VARS            ##
###############################
variable "subscription_id" {
  default = ""
}

variable "tenant_id" {
  default = ""
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

##############################
##  NETWORK VARS            ##
##############################
variable "env_name" {
  default = ""
}

variable "pcf_spoke_resource_group" {
  default = ""
}

variable "pcf_resource_group_name" {
  default = ""
}

variable "dns_server" {
  default = "8.8.8.8"
}

variable "ntp_server" {
  default = ""
}

variable "pcf_depl_name" {
  type    = string
  default = "deploy"
}

variable "pcf_infra_name" {
  type    = string
  default = "infra"
}

variable "pcf_svcs_name" {
  type    = string
  default = "services"
}

variable "pcf_spoke_vnet" {
  type    = string
  default = ""
}

variable "pcf_pks_name" {
  type    = string
  default = "pks-services"
}

variable "pcf_boshdepl_name" {
  type    = string
  default = "bosh-deploy"
}

##############################
##  GENERAL VARS            ##
##############################
variable "env_short_name" {
  description = "Used for creating storage accounts. Must be a-z only, no longer than 10 characters"
  default     = ""
}

variable "dns_suffix" {
  default = ""
}

variable "dns_subdomain" {
  type        = string
  description = "The base subdomain used for PCF. For example, if your dns_subdomain is `cf`, and your dns_suffix is `pivotal.io`, your PCF domain would be `cf.pivotal.io`"
  default     = ""
}

variable "location" {
  default = ""
}

variable "smtp_address" {
  default     = ""
  type        = string
  description = "SMTP Server address.  This is used for PAS Notifications"
}

variable "smtp_from" {
  default     = ""
  type        = string
  description = "EMail Adress you are sending from.  This is used for PAS Notifications"
}

variable "syslog_host" {
  default     = ""
  type        = string
  description = "Syslog endpoint"
}

variable "syslog_port" {
  default     = ""
  type        = string
  description = "Syslog endpoint port"
}

variable "recipient_email" {
  default     = ""
  type        = string
  description = "EMail to send"
}

##################
##  OPSMAN VARS ##
##################
variable "saml_idp_metadata" {
  default = ""
}

variable "saml_rbac_admin_pcf_resource_group_name" {
  default = ""
}

variable "saml_rbac_groups_attribute" {
  default = ""
}

variable "decryption-passphrase" {
  default = ""
}

variable "director_hostname" {
  default = ""
}

variable "cf_storage_account_name" {
  type        = string
  description = "storage account name for cf"
  default     = "cf"
}

variable "ops_manager_vm" {
  default = true
}

variable "ops_manager_image_uri" {
  default = ""
}

variable "ops_manager_private_ip" {
  type        = string
  description = "IP for the Ops Manager instance if not deploying in the default infrastructure subnet"
  default     = "10.0.8.4"
}

variable "ops_manager_vm_size" {
  type    = string
  default = "Standard_DS3_v2"
}

###############
##  PAS VARS ##
###############
variable cf_buildpacks_storage_container_name {
  type        = "string"
  description = "container name for cf buildpacks"
  default     = "buildpacks"
}
variable cf_droplets_storage_container_name {
  type        = "string"
  description = "container name for cf droplets"
  default     = "droplets"
}
variable cf_packages_storage_container_name {
  type        = "string"
  description = "container name for cf packages"
  default     = "packages"
}

variable cf_resources_storage_container_name {
  type        = "string"
  description = "container name for cf resources"
  default     = "resources"
}
variable "web_lb_priv_ip" {
  default = ""
  }
variable "diego_lb_priv_ip" {
  default = ""
  }
variable "mysql_lb_priv_ip" {
  default = ""
  }
variable "tcp_lb_priv_ip" {
  default = ""
  }
variable "lb_subnet_id" {
  default = ""
  }
variable "saml_display_name" {
  type        = string
  description = "Display for the SAML login"
  default     = "My SAML"
}

variable "credhub_encrypt_key" {
  default = ""
}

variable "apps_manager_company_name" {
  default = ""
  type    = string
}

variable "push_apps_manager_footer_text" {
  default = ""
  type    = string
}

variable "push_apps_manager_favicon" {
  default = ""
}

variable "push_apps_manager_square_logo" {
  default = ""
}

variable "push_apps_manager_logo" {
  default = ""
}

variable "pas_saml_sso_url" {
  default     = ""
  description = "SAML SSO for PAS"
}

variable "pcf_infrastructure_subnet" {
  default = ""
}

variable "mysql_monitor_recipient_email" {
  type = string
}

#######################
##  HEALTHWATCH VARS ##
#######################
variable "healthwatch_uaa_user" {
  default = ""
  type    = string
}

variable "healthwatch_uaa_password" {
  default = ""
  type    = string
}

variable "opsman_url" {
  default = ""
}

variable "foundation_name" {
  default = ""
}

################
##  PASW VARS ##
################
variable "windows_password" {
  default = ""
}

variable "numberOfWinCells" {
  default = "5"
}

##################
##  SPLUNK VARS ##
##################
variable "splunk_api_password" {
  default = ""
}
variable "splunk_api_endpoint" {
  default = ""
}
variable "splunk_host" {
  default = ""
}
variable "splunk_token" {
  default = ""
}
variable "splunk_api_user" {
  default = ""
}
variable "splunk_index" {
  default = ""
}

####################
##  RabbitMQ VARS ##
####################
#None needed

####################
##  REDIS VARS ##
####################
#None needed
variable "redis_backup_account" {
  default = ""
}
variable "redis_backup_container" {
  default = ""
}
variable "redis_backup_path" {
  default = ""
}
################
#Azure sb
################
variable "azsb_db_server" {
  default = ""
}

variable "azsb_db_encryption_key" {
  default = ""
}

variable "azsb_db_name" {
  default = ""
}

variable "azsb_db_password" {
  default = ""
}

variable "azsb_db_user" {
  default = ""
}

######################
##  CloudCache VARS ##
######################
#None needed

#################
##  MySQL VARS ##
#################
variable "mysql_backup_account" {
  default = ""
}
variable "mysql_backup_container" {
  default = ""
}
variable "mysql_backup_path" {
  default = ""
}
variable "mysql_subnet_name" {
  default = ""
}
variable "mysql_backup_email" {
  default = ""
}
variable "storage_access_key" {
  default = ""
}

################
#Harbor
################
variable "harbor_static_ip" {
  default = ""
}

variable "harbor_hostname" {
  default = ""
}

variable "harbor_admin_password" {
  default = ""
}

variable "harbor_admin_password_for_smoketest" {
  default = ""
}

variable "harbor_lb_priv_ip" {
  default = ""
}

##########################
#        SSL KEYS        #
##########################
variable "ssl_cert" {
  type        = string
  description = "the contents of an SSL certificate which should be passed to the gorouter, optional if `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_private_key" {
  type        = string
  description = "the contents of an SSL private key which should be passed to the gorouter, optional if `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_ca_cert" {
  type        = string
  description = "the contents of a CA public key to be used to sign a generated certificate for gorouter, optional if `ssl_cert` is provided"
  default     = ""
}

variable "ssl_ca_private_key" {
  type        = string
  description = "the contents of a CA private key to be used to sign a generated certificate for gorouter, optional if `ssl_cert` is provided"
  default     = ""
}

variable "trusted_certs" {
  type        = string
  description = "the contents of an SSL certificate which should be trusted by the platform"
  default     = ""
}

