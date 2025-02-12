terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "azurerm_resource_group" "aca-rg" {
  name     = "aca-rg"
  location = var.location
}

resource "cloudflare_dns_record" "cloudflare" {
  for_each = { for record in var.dns_records : record.record_name => record }

  zone_id = var.zone_id
  type    = each.value.record_type
  name    = each.value.record_name
  content = each.value.content
  comment = each.value.comment
  proxied = each.value.proxied
  ttl     = each.value.ttl
}

resource "azurerm_container_app_environment" "aca-env" {
  name                = "aca-env"
  location            = var.location
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
  depends_on = [ cloudflare_dns_record.cloudflare ]
  provisioner "local-exec" {
    command = "powershell -Command Start-Sleep -Seconds 60"
  }
}

resource "azurerm_container_app_custom_domain" "ac-cd" {
  name = var.custom_domain_name
  container_app_environment_certificate_id = azurerm_container_app_environment_certificate.ac-cert.id
  container_app_id = azurerm_container_app.aca.id
  certificate_binding_type = "SniEnabled"
  depends_on = [
    cloudflare_dns_record.cloudflare,
    null_resource.wait_for_dns
  ]
}
