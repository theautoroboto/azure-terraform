provider "azurerm" {
  version         = "=1.31.0"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

terraform {
  required_version = ">=0.12.8"
  backend "azurerm" {
    storage_account_name = "azppeast7705"
    container_name       = "terraform"
    key                  = "your-subscription/yourstate.tfstate"
    access_key           = ""
  }
}

module "infra" {
  source                            = "git::ssh://git@git_server/modules/infra.git"
  env_name                          = var.env_name
  env_short_name                    = var.env_short_name
  location                          = var.location
  dns_subdomain                     = var.dns_subdomain
  dns_suffix                        = var.dns_suffix
  pcf_resource_group_name           = data.azurerm_resource_group.pcf-rg.name
  pcf_infrastructure_subnet         = data.azurerm_virtual_network.pcf-spoke.subnets[2]
  pcf_virtual_network_address_space = data.azurerm_virtual_network.pcf-spoke.address_spaces
}

module "ops_manager" {
  source = "../modules/ops_manager"

  env_name            = var.env_name
  env_short_name      = var.env_short_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.pcf-rg.name

  vm_count               = var.ops_manager_vm ? 1 : 0
  ops_manager_image_uri  = var.ops_manager_image_uri
  ops_manager_vm_size    = var.ops_manager_vm_size
  ops_manager_private_ip = var.ops_manager_private_ip

  infra_subnet_id   = data.azurerm_subnet.pcf-infra.id
  infra_subnet_cidr = data.azurerm_subnet.pcf-infra.address_prefix
}

module "pas" {
  source = "../modules/pas"

  env_name       = "${var.env_name}"
  location       = "${var.location}"
  env_short_name = "${var.env_short_name}"

  pas_subnet_id        = "${data.azurerm_subnet.pcf-depl.id}"
  pas_subnet_cidr      = "${data.azurerm_subnet.pcf-depl.address_prefix}"
  services_subnet_id   = "${data.azurerm_subnet.pcf-svcs.id}"
  services_subnet_cidr = "${data.azurerm_subnet.pcf-svcs.address_prefix}"
  lb_subnet_id         = "${data.azurerm_subnet.pcf-lb.id}"

  cf_storage_account_name              = "${var.cf_storage_account_name}"
  cf_buildpacks_storage_container_name = "${var.cf_buildpacks_storage_container_name}"
  cf_droplets_storage_container_name   = "${var.cf_droplets_storage_container_name}"
  cf_packages_storage_container_name   = "${var.cf_packages_storage_container_name}"
  cf_resources_storage_container_name  = "${var.cf_resources_storage_container_name}"

  resource_group_name                 = "${data.azurerm_resource_group.pcf-rg.name}"
  network_name                        = "${data.azurerm_virtual_network.pcf-spoke.name}"
  pcf_spoke_resource_group            = "${data.azurerm_virtual_network.pcf-spoke.resource_group_name}"
  web_lb_priv_ip                      = "${var.web_lb_priv_ip}"
  diego_lb_priv_ip                    = "${var.diego_lb_priv_ip}"
  mysql_lb_priv_ip                    = "${var.mysql_lb_priv_ip}"
  tcp_lb_priv_ip                      = "${var.tcp_lb_priv_ip}"
}

module "harbor" {
  source = "../modules/harbor"
  env_id                              = "${var.env_name}"
  location                            = "${var.location}"
  pcf_resource_group_name             = "${var.pcf_resource_group_name}"
  harbor_subnet_id                    = "${data.azurerm_subnet.pcf-svcs.id}"
  lb_subnet_id                        = "${data.azurerm_subnet.pcf-lb.id}"
  harbor_lb_priv_ip                   = "${var.harbor_lb_priv_ip}"
}

