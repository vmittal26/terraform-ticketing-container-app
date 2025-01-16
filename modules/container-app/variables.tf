
variable "db_secret_name" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "app_subnet_id" {
  type = string
}

variable "app_identity_id"{
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

variable "key_vault_id" {
  type = string
}

variable "key_vault_secret_id" {
  type = string
}


variable "container_app" {
  type = map(object(
    {
      name   = string
      image  = string
      PORT   = number
      cpu    = number
      memory = string
      secrets = map(object({
        isSecretRef = bool
        secret_value = string
      }))

  }))
}
