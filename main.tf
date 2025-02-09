module "azure_resources" {
  source              = "./modules/azure"
  location            = "West Europe"
  resource_group_name = "tf-rg"
  acr_login_server    = "eurostacr.azurecr.io"
  acr_username        = var.acr_username
  acr_password        = var.acr_password
  containers = [
    {
      name            = "rostadevcontainer"
      image           = "${var.acr_login_server}/nextjsapp:1.1.2"
      port            = 3000
      cpu             = 1
      memory          = 1
      protocol        = "TCP"
      ip_address_type = "Public"
    }
  ]
}

module "cloudflare" {
  source = "./modules/cloudf"
  zone_id = var.zone_id
  record_type = "A"
  record_name = "azure"
  content = module.azure_resources.container_ip_address
  comment = module.azure_resources.container_name
  proxied = true
}

