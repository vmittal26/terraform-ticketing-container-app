module "resource-group" {
  source      = "./modules/resourcegroup"
  rg_name     = var.rg_name
  rg_location = var.rg_location
}

module "identity" {
  source      = "./modules/app_identity"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  identity_nm = var.identity_nm
  depends_on  = [module.resource-group]
}


module "vnet" {
  source      = "./modules/networking"
  nw_data     = var.nw_data
  rg_name     = var.rg_name
  rg_location = var.rg_location
  depends_on  = [module.resource-group]
}

module "cosmos-db" {
  source             = "./modules/cosmos-db"
  virtual_network_id = module.vnet.virtual_network_id
  pe_subnet_id       = module.vnet.pe-subnet_id
  rg_location        = var.rg_location
  rg_name            = var.rg_name
  depends_on         = [module.resource-group, module.vnet]
}

module "keyvault" {
  source                      = "./modules/key-vault"
  db_secret_name              = var.db_secret_name
  rg_location                 = var.rg_location
  rg_name                     = var.rg_name
  vault_name                  = var.vault_name
  app_identity_id             = module.identity.app_identity_id
  app_identity_principal_id   = module.identity.app_identity_principal_id
  app_identity_tenant_id      = module.identity.app_identity_tenant_id
  cosmos_db_connection_string = module.cosmos-db.cosmos_db_connection_string
  depends_on                  = [module.resource-group, module.identity, module.cosmos-db]

}

module "container_app" {
  source              = "./modules/container-app"
  rg_name             = var.rg_name
  rg_location         = var.rg_location
  virtual_network_id  = module.vnet.virtual_network_id
  container_app       = var.container_app
  app_subnet_id       = module.vnet.container_subnet_id
  app_identity_id     = module.identity.app_identity_id
  key_vault_id        = module.keyvault.key_vault_id
  key_vault_secret_id = module.keyvault.key_vault_secret_id
  db_secret_name      = var.db_secret_name
  depends_on          = [module.keyvault, module.vnet]
}




