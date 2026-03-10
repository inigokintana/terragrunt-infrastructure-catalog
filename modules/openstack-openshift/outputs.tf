output "keypair_name" {
  description = "SSH keypair name"
  value       = openstack_compute_keypair_v2.cluster.name
}

output "master_vm_ids" {
  description = "Master node VM IDs"
  value       = openstack_compute_instance_v2.master[*].id
}

output "master_vm_ips" {
  description = "Master node internal IPs"
  value       = openstack_compute_instance_v2.master[*].access_ip_v4
}

output "worker_vm_ids" {
  description = "Worker node VM IDs"
  value       = openstack_compute_instance_v2.worker[*].id
}

output "worker_vm_ips" {
  description = "Worker node internal IPs"
  value       = openstack_compute_instance_v2.worker[*].access_ip_v4
}

output "api_floating_ip" {
  description = "Floating IP for API access"
  value       = openstack_networking_floatingip_v2.api.address
}

output "master_volume_ids" {
  description = "Master node storage volume IDs"
  value       = openstack_blockstorage_volume_v3.master_storage[*].id
}

output "worker_volume_ids" {
  description = "Worker node storage volume IDs"
  value       = openstack_blockstorage_volume_v3.worker_storage[*].id
}
