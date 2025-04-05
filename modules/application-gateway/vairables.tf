variable "rg_name" {
  type        = string
  description = "Name of the resource"
}

variable "rg_location" {
  type        = string
  description = "Name of the location"
}

variable "app-gw-subnet_id" {
  type        = string
  description = "Gateway sub net id"
}

variable "container_app_auth_fqdn" {
  type = string
}

variable "container_app_ticket_fqdn" {
  type = string
}

variable "container_app_order_fqdn" {
  type = string
}
