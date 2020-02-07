variable "env_name" {}
variable "env_short_name" {}
variable "location" {}
variable "resource_group_name" {}
#Can't register DNS here.  Must be manual in domain.com
# variable "dns_suffix" {}

variable "cf_buildpacks_storage_container_name" {}
variable "cf_droplets_storage_container_name" {}
variable "cf_packages_storage_container_name" {}
variable "cf_resources_storage_container_name" {}
variable "cf_storage_account_name" {}

variable "network_name" {}
variable "pas_subnet_cidr" {}
variable "pas_subnet_id" {}
variable "services_subnet_cidr" {}
variable "services_subnet_id" {}
variable "pcf_spoke_resource_group" {}
# variable "bosh_deployed_vms_security_group_id" {}
# variable "pcfweb_public" {}
variable "web_lb_priv_ip" {}
variable "diego_lb_priv_ip" {}
variable "mysql_lb_priv_ip" {}
variable "tcp_lb_priv_ip" {}
variable "lb_subnet_id" {}