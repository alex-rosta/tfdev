terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "cloudflare_dns_record" "azure" {
  for_each = { for record in var.dns_records : record.record_name => record }

  zone_id = var.zone_id
  type    = each.value.record_type
  name    = each.value.record_name
  content = each.value.content
  comment = each.value.comment
  proxied = each.value.proxied
  ttl     = each.value.ttl
}