resource "azurerm_container_app_environment" "aca_environment" {
  name                           = "test"
  location                       = var.rg_location
  resource_group_name            = var.rg_name
  internal_load_balancer_enabled = true
  infrastructure_subnet_id       = var.app_subnet_id
}

resource "azurerm_container_app" "container_apps" {
  for_each                     = var.container_app
  name                         = each.key
  container_app_environment_id = azurerm_container_app_environment.aca_environment.id
  resource_group_name          = var.rg_name
  revision_mode                = "Single"


  template {
    container {
      name   = each.value.name
      image  = each.value.image
      cpu    = each.value.cpu
      memory = each.value.memory
      

      dynamic "env" {
        for_each = each.value.secrets
        content {
          name        = env.key
          secret_name = env.value.isSecretRef == true ? env.key : null
          value       = env.value.secret_value
        }
      }
    }
  }


  secret {
    name                = var.db_secret_name
    identity            = var.app_identity_id
    key_vault_secret_id = var.key_vault_db_secret_id
  }

 secret {
    name                = var.service_bus_secret_name
    identity            = var.app_identity_id
    key_vault_secret_id = var.key_vault_service_bus_secret_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.app_identity_id]
  }


  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = each.value.PORT
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  lifecycle {
    ignore_changes = [secret]
  }
}
