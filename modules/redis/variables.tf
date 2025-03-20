variable "redis_name" {
  type = string
}
variable "start_ip_allow" {
  type = string
  default = null
  
}
variable "end_ip_allow" {
  type = string
  default = null
}
variable "resource_group_name" {
  type = string
}