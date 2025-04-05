output key_vault_id {
    value = data.azurerm_key_vault.vault-ticketing.id
}

output key_vault_db_secret_id {
    value = azurerm_key_vault_secret.db_secret.id
}

output key_vault_service_bus_secret_id {
    value = azurerm_key_vault_secret.azure_service_bus_secret.id
}