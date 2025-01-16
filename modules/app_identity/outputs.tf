output "app_identity_id" {
  value = azurerm_user_assigned_identity.identity.id
}

output "app_identity_principal_id" {
  value = azurerm_user_assigned_identity.identity.principal_id
}


output "app_identity_tenant_id" {
  value = azurerm_user_assigned_identity.identity.tenant_id
}
