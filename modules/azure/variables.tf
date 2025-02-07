variable "resource_group_name" {}
variable "location" {}
variable "container_name" {}
variable "container_image" {}
variable "container_port" {
    type = number
}
variable "protocol" {
    type = string
}
variable "container_cpu" {
    type = number
}
variable "container_memory" {
    type = number
}

