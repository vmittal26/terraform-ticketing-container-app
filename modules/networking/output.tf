output "virtual_network_id"{
 value = azurerm_virtual_network.virtual_network.id
}

output "container_subnet_id"{
 value = azurerm_subnet.network_subnets["app-subnet"].id
}

output "pe-subnet_id" {
  value = azurerm_subnet.network_subnets["pe-subnet"].id
}