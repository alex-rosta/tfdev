module "azure_container_apps" {
  source = "./modules/aca"
  location = "West Europe"
  app_name = "aca"
  image = "alexrsit/nextjsapp:1.1.2"
  cpu = "0.5"
  memory = "1Gi"
  external_enabled = true
  target_port = 3000
  resource_group_name = "aca-rg"
  certificate_friendly_name = "rosta.dev"
  certificate_path = "./certificate/cert.pfx"
  certificate_password = var.certificate_password
  custom_domain_name = "aca.rosta.dev"
}

module "cloudflare_dns_record" {
  source = "./modules/cloudf"
  zone_id = var.zone_id
  dns_records = [
    {
      record_type = "TXT"
      record_name = "asuid.aca.rosta.dev"
      content = module.azure_container_apps.custom_domain_verification_id
      proxied = false
      ttl = 1
    },
    {
      record_type = "A"
      record_name = "aca.rosta.dev"
      content = module.azure_container_apps.static_ip_address
      proxied = true
      ttl = 1
    }
  ]
}

