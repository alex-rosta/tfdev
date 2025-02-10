resource "azurerm_resource_group" "aca-rg" {
  name     = "aca-rg"
  location = var.location
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
    container {
      name   = var.app_name
      image  = var.image
      cpu    = var.cpu
      memory = var.memory
    }
  }

  ingress {
    external_enabled = var.external_enabled
    target_port      = var.target_port
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}
