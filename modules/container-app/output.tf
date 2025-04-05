output container_app_auth_fqdn {
   value = azurerm_container_app.container_apps["auth"].ingress[0].fqdn
}

output container_app_ticket_fqdn {
   value = azurerm_container_app.container_apps["ticket"].ingress[0].fqdn  
}

output container_app_order_fqdn {
      value = azurerm_container_app.container_apps["order"].ingress[0].fqdn 
}