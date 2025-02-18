variable "resource_group_name" {}
variable "location" {}
variable "acr_login_server" {}
variable "acr_username" {}
variable "acr_password" {}
variable "ip_address_type" {
  type    = string
  default = "Public"
}

variable "containers" {
  type = list(object({
    name                  = string
    image                 = string
    port                  = optional(number)
    cpu                   = number
    memory                = number
    environment_variables = optional(map(string), {})
    protocol              = optional(string)
    command               = optional(list(string), null)
    ip_address_type       = optional(string)
  }))
}

