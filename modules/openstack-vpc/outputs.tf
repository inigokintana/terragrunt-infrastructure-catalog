output "network_id" {
  description = "OpenStack network ID"
  value       = openstack_networking_network_v2.main.id
}

output "network_name" {
  description = "OpenStack network name"
  value       = openstack_networking_network_v2.main.name
}

output "subnet_id" {
  description = "OpenStack subnet ID"
  value       = openstack_networking_subnet_v2.main.id
}

output "subnet_cidr" {
  description = "OpenStack subnet CIDR"
  value       = openstack_networking_subnet_v2.main.cidr
}

output "router_id" {
  description = "OpenStack router ID"
  value       = openstack_networking_router_v2.main.id
}

output "security_group_id" {
  description = "Default security group ID"
  value       = openstack_networking_secgroup_v2.default.id
}

output "external_network_id" {
  description = "External network ID"
  value       = data.openstack_networking_network_v2.external.id
}
