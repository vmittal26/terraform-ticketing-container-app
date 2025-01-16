output key_vault_id {
    value = data.azurerm_key_vault.vault-ticketing.id
}

output key_vault_secret_id {
    value = azurerm_key_vault_secret.secret.id
}