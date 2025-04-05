variable "rg_name" {
  type        = string
  description = "Name of the resource"
}

variable "rg_location" {
  type        = string
  description = "Name of the location"
}


variable virtual_network_id {
    type = string
}

variable service_bus_subnet_id {
    type = string
}

variable "subscriptions" {
  type = list(object({
    name         = string
    filter_type  = string
    filter_value = string
  }))
}
