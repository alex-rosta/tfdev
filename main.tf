module "azure_resources" {
  source              = "./modules/azure"
  location            = "West Europe"
  resource_group_name = "tf-rg"
  container_name      = "rostadevcontainer"
  container_image     = "alexrsit/nextjsapp:1.1.2"
  container_port      = 3000
  container_cpu       = 1
  container_memory    = 1
  protocol            = "TCP"
}

module "cloudflare_dns" {
  source = "./modules/cloudf"
  providers = {
    cloudflare = cloudflare
  }
  zone_id     = var.zone_id
  record_type = "A"
  record_name = "azure"
  proxied     = false
  content     = module.azure_resources.container_ip_address
  comment     = module.azure_resources.container_name
  ttl         = 3600
}

