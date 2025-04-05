output "virtual_network_id"{
 value = azurerm_virtual_network.virtual_network.id
}

output "container_subnet_id"{
 value = azurerm_subnet.network_subnets["app-subnet"].id
}

output "pe-subnet_id" {
  value = azurerm_subnet.network_subnets["pe-subnet"].id
}


output "service_bus_subnet_id"{
 value = azurerm_subnet.network_subnets["service-bus-subnet"].id
}

output "app-gw-subnet_id"{
  value = azurerm_subnet.network_subnets["gw-subnet"].id
}