terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "cloudflare_dns_record" "azure" {
  zone_id = var.zone_id
  type    = var.record_type
  name    = var.record_name
  content = var.content
  comment = var.comment
  proxied = var.proxied
  ttl = var.ttl
}