output "bridge_name" {
  description = "Network bridge name"
  value       = var.bridge_name
}

output "interface_name" {
  description = "Physical interface name"
  value       = var.interface_name
}

output "bridge_address" {
  description = "Bridge IP address"
  value       = var.bridge_address
}

output "bridge_netmask" {
  description = "Bridge netmask"
  value       = var.bridge_netmask
}

output "vlan_id" {
  description = "VLAN ID"
  value       = var.vlan_id
}

output "gateway" {
  description = "Gateway IP"
  value       = var.gateway
}

output "config_file" {
  description = "Path to network configuration file"
  value       = local_file.network_config.filename
}
