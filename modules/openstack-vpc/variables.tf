variable "network_name" {
  type        = string
  description = "Name of the OpenStack network"
}

variable "network_cidr" {
  type        = string
  description = "CIDR block for the network"
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "dns_nameservers" {
  type        = list(string)
  description = "DNS nameservers for the subnet"
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "router_name" {
  type        = string
  description = "Name of the router"
}

variable "external_network_name" {
  type        = string
  description = "Name of the external network to connect router to"
  default     = "public"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
