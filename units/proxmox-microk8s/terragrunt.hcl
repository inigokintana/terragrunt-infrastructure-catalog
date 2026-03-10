include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/proxmox-microk8s"
}

inputs = {
  proxmox_node    = values.proxmox_node
  cluster_name    = values.cluster_name
  vm_count        = try(values.vm_count, 3)
  vm_id_start     = try(values.vm_id_start, 100)
  cpu_cores       = try(values.cpu_cores, 2)
  memory_mb       = try(values.memory_mb, 2048)
  disk_size_gb    = try(values.disk_size_gb, 20)
  template_name   = values.template_name
  bridge_name     = try(values.bridge_name, "vmbr0")
  start_index     = try(values.start_index, 10)
  gateway_ip      = try(values.gateway_ip, "192.168.1.1")
  subnet_mask     = try(values.subnet_mask, "24")
  dns_servers     = try(values.dns_servers, ["8.8.8.8", "8.8.4.4"])
  tags            = try(values.tags, {})
}
