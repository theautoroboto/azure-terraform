terraform { required_version   = ">=0.12.8" }
provider "azurerm" {
  version         = ">=1.36"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
provider "azuread" { version  = ">=0.6" }
provider "random" { version   = ">=2.2"}

# First, we create a place for everything to live
resource "azurerm_resource_group" "pcf_resource_group" {
  name     = "${var.env_name}-rg1"
  location = var.location
}

module "svc_pal" {
  source = "git::ssh://git@git_server/az-pcf/modules/svc_pal.git?ref=v1.4.6"

  env_short_name            = var.env_short_name
  pcf_spoke_resource_group  = var.pcf_spoke_resource_group
  pcf_spoke_vnet            = var.pcf_spoke_vnet
  rsrc_grp_id               = azurerm_resource_group.pcf_resource_group.id
}

# module "keyvault" {
#   source = "git::ssh://git@git_server/terraform-modules/etg/azure/akv.git"
# }

# Also attach a specific group as an owner so the PCF team can administer these components
# resource "azurerm_role_assignment" "pcf-team" {
#     scope                = azurerm_resource_group.pcf_resource_group.id
#     role_definition_name = "Owner"
#     principal_id         = data.azuread_group.pcf.id
# }

# The random_id resource is used to "guarantee" unique resources, especially where we have
# stringent naming requirements like on a Storage Account. This resource will be recreated
# if the Resource Group's ID changes - effectively if we recreate the Resource Group itself
resource "random_id" "storage_account" {
  keepers = {
    sa_id = azurerm_resource_group.pcf_resource_group.id
  }
  byte_length = 2
}

# Now a Storage Account is created that we can generally put to use. I'm storing some
# Terraform state here, OpsMan VHD, and perhaps Tiles in the future. It's all stored
# in containers that we'll allocate now.
resource "azurerm_storage_account" "pcf_general_sa" {
  name                      = "${var.env_short_name}${random_id.storage_account.hex}"
  resource_group_name       = azurerm_resource_group.pcf_resource_group.name
  location                  = var.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  enable_https_traffic_only = true
  # account_encryption_source = "Microsoft.KeyVault"

  # TODO: Requires Service Endpoint Microsoft.Storage on Infra subnet
  network_rules {
    default_action             = "Deny"
    bypass                     = ["Logging","Metrics","AzureServices"]
    virtual_network_subnet_ids = [data.azurerm_subnet.infra.id]
    ip_rules                    = ["x.x.x.x","x.x.x.x"]
  }
}

resource "azurerm_storage_container" "pcf_terraform" {
  name                  = "terraform"
  depends_on            = [azurerm_storage_account.pcf_general_sa]
  storage_account_name  = azurerm_storage_account.pcf_general_sa.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "ops_manager_storage_container" {
  name                  = "opsmanagerimage"
  depends_on            = [azurerm_storage_account.pcf_general_sa]
  storage_account_name  = azurerm_storage_account.pcf_general_sa.name
  container_access_type = "private"
}