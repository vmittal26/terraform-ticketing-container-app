terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.6.0"
    }
    azapi = {   
      source = "azure/azapi"
    }
  }
}

provider "azurerm" {
  subscription_id = "3fca4538-23fa-4853-94bd-604378fbbb2b"
  tenant_id       = "bf0c06c2-6aa7-4abe-9732-ce9b2b3c7264"
  client_id       = "0cb15086-3fbc-4228-8b15-0ed4a10fba62"
  client_secret   = "1c78Q~Tx..y_88BmcO2rn1oJglq.3kCpssJJzcOJ"
  features {}
  
}