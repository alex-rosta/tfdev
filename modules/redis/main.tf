resource "azurerm_resource_group" "redis-rg" {
  name     = var.resource_group_name
  location = "West Europe"

}

resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  resource_group_name  = "${var.redis_name}-rg"
  location             = azurerm_resource_group.redis-rg.location
  sku_name             = "Basic"
  capacity             = 2
  family               = "C"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
}