variable "vault_name"{
  type = string
}
variable "db_secret_name" {
  type = string
}

variable "service_bus_secret_name" {
  type = string
}

variable "rg_name" {
  type        = string
  description = "Name of the resource"
}

variable "rg_location" {
  type        = string
  description = "Name of the location"
}


variable "app_identity_id"{
  type = string
}

variable "app_identity_principal_id"{
  type = string
}

variable "app_identity_tenant_id"{
  type = string
}

variable "cosmos_db_connection_string" {
  type = string
}
variable "azure_service_bus_connection_string"{
  type = string
}