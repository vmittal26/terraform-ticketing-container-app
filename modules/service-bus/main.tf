
locals {

  location                   = "West Europe"
  dns_name                   = "privatelink.servicebus.windows.net"
  vnet_link                  = "vnet-link"
  sb_namespace               = "az-service-bus-namespace"
  sb_topic_name              = "ticketing-topic"
  sb_namespace_auth_rule     = "${local.sb_namespace}_auth_rule"
  pe_name                    = "${local.sb_namespace}_private_endpoint"
  private_service_connection = "${local.pe_name}_service_connection"
  private_dns_link           = "${local.sb_namespace}_dns_link"
  private_dns_zone_group     = "${local.sb_namespace}-private_dns_zone_group"

}


# Service Bus Namespace
resource "azurerm_servicebus_namespace" "sb" {
  name                          = local.sb_namespace
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  sku                           = "Standard" # Required for Topics
  public_network_access_enabled = false      # Disables public access

}