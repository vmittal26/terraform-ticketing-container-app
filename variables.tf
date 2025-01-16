variable "rg_name" {
  type        = string
  description = "Name of the resource"
}

variable "rg_location" {
  type        = string
  description = "Name of the location"
}

variable "vnet_subnet_count" {
  type = number
}

variable "identity_nm" {
  type = string
}

variable "vault_name" {
  type = string
}



variable "db_secret_name" {
  type = string
}



variable "nw_data" {
  type = map(object(
    {
      vnet_name          = string
      vnet_address_space = string
      subnets = map(object(
        {
          address_space = string
        }
      ))
  }))
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
