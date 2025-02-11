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