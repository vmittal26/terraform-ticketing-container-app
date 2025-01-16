locals {
  rg_name                    = "db-rg"
  db_location                = "South India"
  location                   = "West Europe"
  dns_name                   = "privatelink.mongo.cosmos.azure.com"
  vnet_link                  = "vnet-link"
  cosmos_db_account_name     = "az-cosmos-mongo-db"
  pe_name                    = "cosmos_db_private_endpoint"
  private_service_connection = "cosmos_db_private_endpoint_service_connection"
  private_dns_zone_group     = "cosmos_db_private_dns_zone_group"
}


resource "azurerm_resource_group" "db-rg" {
  name     = local.rg_name
  location = local.db_location
}


resource "azurerm_cosmosdb_account" "az-cosmos-mongo-db" {
  name                          = local.cosmos_db_account_name
  location                      = azurerm_resource_group.db-rg.location
  resource_group_name           = azurerm_resource_group.db-rg.name
  offer_type                    = "Standard"
  kind                          = "MongoDB"
  free_tier_enabled             = true
  public_network_access_enabled = false

  geo_location {
    location          = azurerm_resource_group.db-rg.location
    failover_priority = 0
  }

  consistency_policy {
    consistency_level = "Session"
  }
}

# Private DNS Zone for Cosmos DB
resource "azurerm_private_dns_zone" "pe-dns" {
  name                = local.dns_name
  resource_group_name = var.rg_name
}


# Virtual Network Link to Private DNS Zone
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-link" {
  name                  = local.vnet_link
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.pe-dns.name
  virtual_network_id    = var.virtual_network_id
}


# Private Endpoint for Cosmos DB
resource "azurerm_private_endpoint" "pe-cosmosdb" {
  name                = local.pe_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = local.private_service_connection
    private_connection_resource_id = azurerm_cosmosdb_account.az-cosmos-mongo-db.id
    is_manual_connection           = false
    subresource_names              = ["MongoDB"] # Change based on the required API: `sql`, `mongo`, etc.
  }

  private_dns_zone_group {
    name                 = local.private_dns_zone_group
    private_dns_zone_ids = [azurerm_private_dns_zone.pe-dns.id]
  }

}
