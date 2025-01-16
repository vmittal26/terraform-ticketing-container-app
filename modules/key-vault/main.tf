data "azurerm_key_vault" "vault-ticketing" {
  name                = "vault-ticketing"
  resource_group_name = "vault-rg" # Replace with your resource group name
}
data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "role" {
  name = "Key Vault Administrator"
}

resource "azurerm_role_assignment" "role_assigment" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.role.id}"
  principal_id       = var.app_identity_principal_id
}
resource "azurerm_key_vault_secret" "secret" {
  name         = var.db_secret_name
  value        = var.cosmos_db_connection_string
  key_vault_id = data.azurerm_key_vault.vault-ticketing.id
}