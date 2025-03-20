module "azure_container_apps" {
  source                    = "./modules/aca"
  app_name                  = "armory"
  image                     = "alexrsit/armory:latest"
  cpu                       = "0.5"
  memory                    = "1Gi"
  external_enabled          = true
  target_port               = 3000
  certificate_friendly_name = "rosta.dev"
  certificate_path          = "./certificate/cert.pfx"
  certificate_password      = var.certificate_password
  zone_id                   = var.zone_id
  root_domain               = "rosta.dev"
  env = {
    "REDIS_CLOUD"   = true
    "CLIENT_ID"     = var.CLIENT_ID
    "CLIENT_SECRET" = var.CLIENT_SECRET
    "REDIS_ADDR"    = module.azure_redis.hostname
  }
}

module "azure_redis" {
  source              = "./modules/redis"
  resource_group_name = module.azure_container_apps.resource_group_name
  redis_name = "armory-redis"
}


