output "container_ip_address" {
    value = azurerm_container_group.container_group.ip_address
}
output "container_name" {
    value = azurerm_container_group.container_group.name
}