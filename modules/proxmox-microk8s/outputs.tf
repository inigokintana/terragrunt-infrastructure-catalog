output "vm_ids" {
  description = "Proxmox VM IDs"
  value       = proxmox_vm_qemu.microk8s[*].vmid
}

output "vm_names" {
  description = "VM names"
  value       = proxmox_vm_qemu.microk8s[*].name
}

output "vm_ips" {
  description = "VM IP addresses"
  value       = [for i in range(var.vm_count) : "192.168.1.${var.start_index + i}"]
}

output "cluster_name" {
  description = "Microk8s cluster name"
  value       = var.cluster_name
}

output "node_name" {
  description = "Proxmox node hosting the cluster"
  value       = var.proxmox_node
}
