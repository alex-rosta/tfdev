output "hostname" {
  value = azurerm_redis_cache.redis.hostname
}

output "primary_access_key" {
  value = azurerm_redis_cache.redis.primary_access_key
}

output "redis_cache_name" {
  value = azurerm_redis_cache.redis.name
}