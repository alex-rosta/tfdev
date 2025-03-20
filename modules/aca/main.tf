terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "azurerm_resource_group" "aca-rg" {
  name     = "${var.app_name}-rg"
  location = "West Europe"
}

resource "cloudflare_dns_record" "a-record" {
  zone_id = var.zone_id
  type    = "A"
  name    = "${var.app_name}.${var.root_domain}"
  content = azurerm_container_app_environment.aca-env.static_ip_address
  comment = var.app_name
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "txt_record" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "asuid.${var.app_name}.${var.root_domain}"
  content = azurerm_container_app.aca.custom_domain_verification_id
  comment = var.app_name
  proxied = false
  ttl     = 1
}

resource "azurerm_container_app_environment" "aca-env" {
  name                = var.app_name
  location            = azurerm_resource_group.aca-rg.location
  resource_group_name = azurerm_resource_group.aca-rg.name
}

resource "azurerm_container_app" "aca" {
  name                         = var.app_name
  resource_group_name          = azurerm_resource_group.aca-rg.name
  container_app_environment_id = azurerm_container_app_environment.aca-env.id
  revision_mode                = "Single"

  template {
    max_replicas = 1
    container {
      name   = var.app_name
      image  = var.image
      cpu    = var.cpu
      memory = var.memory
      dynamic "env" {
        for_each = var.env
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  ingress {
    external_enabled           = var.external_enabled
    target_port                = var.target_port
    allow_insecure_connections = true
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azurerm_container_app_environment_certificate" "ac-cert" {
  name                         = var.certificate_friendly_name
  container_app_environment_id = azurerm_container_app_environment.aca-env.id
  certificate_blob_base64      = filebase64(var.certificate_path)
  certificate_password         = var.certificate_password
}

resource "null_resource" "wait_for_dns" {
  depends_on = [cloudflare_dns_record.txt_record]
  provisioner "local-exec" {
    command = "powershell -Command Start-Sleep -Seconds 60"
  }
}

resource "azurerm_container_app_custom_domain" "ac-cd" {
  name                                     = "${var.app_name}.${var.root_domain}"
  container_app_environment_certificate_id = azurerm_container_app_environment_certificate.ac-cert.id
  container_app_id                         = azurerm_container_app.aca.id
  certificate_binding_type                 = "SniEnabled"
  depends_on = [
    cloudflare_dns_record.txt_record,
    null_resource.wait_for_dns
  ]
}
