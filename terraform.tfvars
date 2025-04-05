rg_name           = "rg"
rg_location       = "East US"
vnet_subnet_count = 3
identity_nm       = "app_identity"
vault_name        = "ticketing-vault"
nw_data = {
  data = {
    vnet_name          = "app_vnet"
    vnet_address_space = "10.0.0.0/16"
    subnets = {
      gw-subnet = {
        address_space = "10.0.3.0/24"
      }
      pe-subnet = {
        address_space = "10.0.1.0/24"
      },
      service-bus-subnet = {
        address_space = "10.0.2.0/24"
      }
      app-subnet = {
        address_space = "10.0.4.0/23"
      }
    }
  }

}

db_secret_name = "mongo-db-conn-str"
service_bus_secret_name = "service-bus-conn-string"

container_app = {
  auth = {
    name   = "auth"
    image  = "docker.io/vmittal26/auth:v1"
    PORT   = 5000
    cpu    = 0.25
    memory = "0.5Gi"
    secrets = {
      mongo-db-conn-str = {
        isSecretRef  = true
        secret_value = "secretref:mongo-db-conn-str"
      }

      service_port_name = {
        isSecretRef  = false
        secret_value = "5000"
      }
    }
  }
  order = {
    name   = "order"
    image  = "docker.io/vmittal26/orders:v1"
    PORT   = 5000
    cpu    = 0.25
    memory = "0.5Gi"
    secrets = {
      mongo-db-conn-str = {
        isSecretRef  = true
        secret_value = "secretref:mongo-db-conn-str"
      }

      service_port_name = {
        isSecretRef  = false
        secret_value = "5000"
      }
    }


  }

  ticket = {
    name   = "ticket"
    image  = "docker.io/vmittal26/tickets:v1"
    PORT   = 5000
    cpu    = 0.25
    memory = "0.5Gi"

    secrets = {
      mongo-db-conn-str = {
        isSecretRef  = true
        secret_value = "secretref:mongo-db-conn-str"
      }

      service_port_name = {
        isSecretRef  = false
        secret_value = "5000"
      }
    }

  }

}

subscriptions = [
    {
      name         = "ticket"
      filter_type  = "SqlFilter"
      filter_value = "eventType = 'ticket-created'"
    },
    {
      name         = "order"
      filter_type  = "SqlFilter"
      filter_value = "eventType = 'order-created'"
    }
  ]
