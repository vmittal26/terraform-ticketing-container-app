output azure_service_bus_connection_string {
    value = azurerm_servicebus_namespace_authorization_rule.auth_rule.primary_connection_string
    
}