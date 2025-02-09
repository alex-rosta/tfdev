variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "email" {
  description = "Cloudflare email"
  type        = string
}

variable "api_token" {
  description = "Cloudflare API token"
  type        = string
}

variable "zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "cloudflared_token" {
  description = "Cloudflared token"
  type        = string
}

variable "acr_login_server" {
  description = "Azure Container Registry login server"
  type        = string
}

variable "acr_username" {
  description = "Azure Container Registry username"
  type        = string
}

variable "acr_password" {
  description = "Azure Container Registry password"
  type        = string
}

variable "ip_address_type" {
  description = "IP address type"
  type        = string
  default     = "Public"
}