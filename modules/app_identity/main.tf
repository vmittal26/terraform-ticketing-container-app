# Configure the Azure provider
resource "azurerm_user_assigned_identity" "identity" {
  name                = var.identity_nm
  resource_group_name = var.rg_name
  location            = var.rg_location
}