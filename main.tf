module "azure_container_apps" {
  source = "./modules/aca"
  location = "West Europe"
  app_name = "aca"
  image = "nginx"
  cpu = "0.5"
  memory = "1.5"
  external_enabled = true
  target_port = 80
  resource_group_name = "aca-rg"
}

module "cloudflare_dns" {
  source = "./modules/cloudf"
  zone_id = "zone_id"
  record_type = "TXT"
  record_name = "aca"
  content = module.azure_container_apps.custom_domain_verification_id
  comment = "Azure Container Apps"
  proxied = true
}

