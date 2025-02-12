variable "resource_group_name" {}
variable "location" {}
variable "app_name" {}

variable "image" {}
variable "cpu" {}
variable "memory" {}
variable "external_enabled" {}
variable "target_port" {}
variable "certificate_friendly_name" {}
variable "certificate_path" {}
variable "certificate_password" {}
variable "custom_domain_name" {}

variable "zone_id" {}

variable "dns_records" {
  type = list(object({
    record_type = string
    record_name = string
    content     = string
    comment     = optional(string)
    proxied     = bool
    ttl         = optional(number)
  }))
}