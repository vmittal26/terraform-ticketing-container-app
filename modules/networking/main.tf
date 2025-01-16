resource "azurerm_virtual_network" "virtual_network"{
    name = var.nw_data.data.vnet_name
    location = var.rg_location
    resource_group_name = var.rg_name
    address_space = [var.nw_data.data.vnet_address_space]
}
resource "azurerm_subnet" "network_subnets" {
  for_each = var.nw_data.data.subnets
  name = each.key 
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [each.value.address_space]

}