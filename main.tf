module "azure_container_apps" {
  source                    = "./modules/aca"
  location                  = "West Europe"
  app_name                  = "azure"
  image                     = "alexrsit/nextjsapp:1.1.2"
  cpu                       = "0.5"
  memory                    = "1Gi"
  external_enabled          = true
  target_port               = 3000
  certificate_friendly_name = "rosta.dev"
  certificate_path          = "./certificate/cert.pfx"
  certificate_password      = var.certificate_password
  zone_id                   = var.zone_id
  root_domain               = "rosta.dev"
  redis_name                = "azure-redis"
  sku_name                  = "Basic"
  capacity                  = 2

}


