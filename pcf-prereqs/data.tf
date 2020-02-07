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

# This group reader is special and comes from the AzureAD provider
data "azuread_group" "pcf" {
    name = var.owner
}

# VNET (used by PCF) details
data "azurerm_virtual_network" "pcf-spoke" {
  name                = var.pcf_spoke_vnet
  resource_group_name = var.pcf_spoke_resource_group
}

data "azurerm_subnet" "infra" {
  name                 = "infra"
  virtual_network_name = var.pcf_spoke_vnet
  resource_group_name  = var.pcf_spoke_resource_group
}