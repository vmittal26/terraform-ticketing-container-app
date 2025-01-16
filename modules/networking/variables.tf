variable "rg_name" {
  type        = string
  description = "Name of the resource"
}

variable "rg_location" {
  type        = string
  description = "Name of the location"
}

variable "nw_data" {
  type = map(object({
    vnet_name          = string
    vnet_address_space = string
    subnets = map(object({
      address_space = string
    }))
  }))
}

