output "pcf_resource_group" {
  value = azurerm_resource_group.pcf_resource_group.name
}

output "pcf_general_sa" {
  value = azurerm_storage_account.pcf_general_sa.name
}

output "pcf_general_sa_key" {
  value = azurerm_storage_account.pcf_general_sa.primary_access_key
}

output "pcf_service_principal_id" {
  value = module.svc_pal.pcf_sp_id
}

output "pcf_service_principal_name" {
  value = module.svc_pal.pcf_sp_name
}