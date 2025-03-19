output "custom_domain_verification_id" {
  value = azurerm_container_app.aca.custom_domain_verification_id
}

output "static_ip_address" {
  value = azurerm_container_app_environment.aca-env.static_ip_address

}

output "container_app_id" {
  value = azurerm_container_app.aca.id
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.aca-env.id
}

output "container_app_environment_certificate_id" {
  value = azurerm_container_app_environment_certificate.ac-cert.id
}

output "container_app_custom_domain_name" {
  value = azurerm_container_app_custom_domain.ac-cd.name

}

output "resource_group_name" {
  value = azurerm_resource_group.aca-rg.name
}