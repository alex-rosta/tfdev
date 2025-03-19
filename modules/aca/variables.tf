variable "app_name" {
  description = "Application name"
  type        = string
}
variable "image" {}
variable "cpu" {}
variable "memory" {}
variable "external_enabled" {}
variable "target_port" {}
variable "certificate_friendly_name" {}
variable "certificate_path" {}
variable "certificate_password" {}
variable "root_domain" {}
variable "zone_id" {}