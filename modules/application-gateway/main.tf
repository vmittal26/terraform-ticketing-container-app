# since these variables are re-used - a locals block makes this more maintainabl
locals {
  app-gateway-public-ip =  "${var.rg_name}-public-ip"
  backend_auth_address_pool_name      = "${var.rg_name}-auth"
  backend_order_address_pool_name      = "${var.rg_name}-order"
  backend_ticketing_address_pool_name      = "${var.rg_name}-ticketing"
  frontend_port_name             = "${var.rg_name}-feport"
  frontend_ip_configuration_name = "${var.rg_name}-feip"
  gateway_ip_configuration  = "${var.rg_name}-gateway-ip"
  http_setting_name              = "${var.rg_name}-be-htst"
  listener_name                  = "${var.rg_name}-server"
  request_routing_rule_ticketing_app_name      = "${var.rg_name}-rule"
  redirect_configuration_name    = "${var.rg_name}-rdrcfg"
  path_rule =  "${var.rg_name}-url-path-mapping-rule"
}

resource "azurerm_public_ip" "appgw_public_ip" {
  name                = local.app-gateway-public-ip
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app-gateway" {
  name                = "app-gateway"
  resource_group_name = var.rg_name
  location            = var.rg_location
  depends_on = [ azurerm_container_app_environment.aca_environment]

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration
    subnet_id = var.app-gw-subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  backend_address_pool {
    name = local.backend_auth_address_pool_name
    fqdns =  [var.container_app_auth_fqdn]
  }

  backend_address_pool {
    name = local.backend_order_address_pool_name
    fqdns =  [var.container_app_ticket_fqdn]
  }

  backend_address_pool {
    name = local.backend_ticketing_address_pool_name
    fqdns =  [var.container_app_order_fqdn]
  }

  backend_http_settings {
    name                                = local.http_setting_name
    port                                = 443
    protocol                            = "Https"
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true # false
    affinity_cookie_name                = "ApplicationGatewayAffinity"
    request_timeout                     = 20
    path = "/"
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_ticketing_app_name
    priority                   = 1
    rule_type                  = "PathBasedRouting"
    http_listener_name         = local.listener_name
    url_path_map_name          = local.path_rule
  }

   url_path_map {
      name                               = local.path_rule
      default_backend_address_pool_name  = local.backend_auth_address_pool_name
      default_backend_http_settings_name = local.http_setting_name
      path_rule {
          name                       = "rule1"
          paths                      = ["/auth","/auth/*"]
          backend_address_pool_name = local.backend_auth_address_pool_name
          backend_http_settings_name = local.http_setting_name
      }
      path_rule {
          name                       = "rule2"
          paths                      = ["/orders","/orders/*"]
          backend_address_pool_name = local.backend_order_address_pool_name
          backend_http_settings_name = local.http_setting_name
      }
      path_rule {
          name                       = "rule3"
          paths                      = ["/ticketing","/ticketing/*"]
          backend_address_pool_name = local.backend_ticketing_address_pool_name
          backend_http_settings_name = local.http_setting_name
      }
   }
  }


 
