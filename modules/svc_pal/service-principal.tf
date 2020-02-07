variable "env_short_name" {}
variable "pcf_spoke_resource_group" {}
variable "pcf_spoke_vnet" {}
variable "rsrc_grp_id" {}

# necessary to data source the subscription ID
data "azurerm_subscription" "sub" {}

# Basic "readers" to fetch the role objects out of AAD
data "azurerm_role_definition" "az-Reader" {
  name                = "Reader"
  scope               = data.azurerm_subscription.sub.id
}

data "azurerm_role_definition" "az-NetContrib" {
  name                = "Network Contributor"
  scope               = data.azurerm_subscription.sub.id
}

data "azurerm_role_definition" "az-Contributor" {
    name               = "Contributor"
    scope               = data.azurerm_subscription.sub.id
}

data "azurerm_role_definition" "az-Owner" {
    name               = "Owner"
    scope               = data.azurerm_subscription.sub.id
}

# VNET (used by PCF) details
data "azurerm_virtual_network" "pcf-spoke" {
  name                = "${var.pcf_spoke_vnet}"
  resource_group_name = "${var.pcf_spoke_resource_group}"
}

# Second, you'll need a service principal to do work in Azure on PCF's behalf. I create an 
# Application Registration, then associate a Service Principal to that. Finally, I create a 
# password for that Service Principal.
resource "azuread_application" "pcf-app" {
  name                       = "${var.env_short_name}-pcf-app"
  oauth2_allow_implicit_flow = true
  available_to_other_tenants = false
}

resource "azuread_service_principal" "pcf-sp" {
  application_id = azuread_application.pcf-app.application_id
}

resource "azuread_service_principal_password" "pcf-sp-pwd" {
  service_principal_id = azuread_service_principal.pcf-sp.id
  value                = "t8+ldrrLYVqMTzLFBvzLpNR2"
  # If we use a dynamic end_date, the password will always be recreated.
  # end_date             = timeadd(timestamp(),"8760h")
  end_date             = "2020-10-29T22:37:57Z"
}

# Now that we have an Application Registration and a Service Principal, I give it some roles
# within the environment where PCF will be working
# Subscription...
resource "azurerm_role_assignment" "pcf-role-sub" {
  scope              = data.azurerm_subscription.sub.id
  role_definition_id = data.azurerm_role_definition.az-Reader.id
  principal_id       = azuread_service_principal.pcf-sp.id
}

# Resource Group...
resource "azurerm_role_assignment" "role-rg" {
  scope              = var.rsrc_grp_id
  role_definition_id = data.azurerm_role_definition.az-Contributor.id
  principal_id       = azuread_service_principal.pcf-sp.id
}

# VNET and subnets
resource "azurerm_role_assignment" "role-vnet" {
  scope              = data.azurerm_virtual_network.pcf-spoke.id
  role_definition_id = data.azurerm_role_definition.az-NetContrib.id
  principal_id       = azuread_service_principal.pcf-sp.id
}

output "pcf_service_principal" {
  value = azuread_service_principal.pcf-sp.id
}