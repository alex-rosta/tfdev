variable "zone_id" {}
variable "record_type" {}
variable "record_name" {}
variable "content" {}
variable "comment" {}
variable "ttl" {
    type = number
    default = 1
}
variable "proxied" {
    type = bool
    default = true
}