include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  stack_name = "microk8s-foundation"
}

unit "networking" {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//units/proxmox-networking?ref=${values.version}"
  path   = "networking"

  values = {
    version         = values.version
    nodes           = try(values.nodes, ["pve"])
    bridge_name     = values.bridge_name
    interface_name  = values.interface_name
    bridge_address  = values.bridge_address
    bridge_netmask  = try(values.bridge_netmask, "24")
    vlan_id         = try(values.vlan_id, 0)
    gateway         = try(values.gateway, "")
    comment         = try(values.comment, local.stack_name)
    auto_start      = try(values.auto_start, true)
  }
}

unit "microk8s" {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//units/proxmox-microk8s?ref=${values.version}"
  path   = "microk8s"

  values = {
    version         = values.version
    proxmox_node    = values.proxmox_node
    cluster_name    = values.cluster_name
    vm_count        = try(values.vm_count, 3)
    vm_id_start     = try(values.vm_id_start, 100)
    cpu_cores       = try(values.cpu_cores, 2)
    memory_mb       = try(values.memory_mb, 2048)
    disk_size_gb    = try(values.disk_size_gb, 20)
    template_name   = values.template_name
    bridge_name     = values.bridge_name
    start_index     = try(values.start_index, 10)
    gateway_ip      = try(values.gateway_ip, values.bridge_address)
    subnet_mask     = try(values.subnet_mask, values.bridge_netmask)
    dns_servers     = try(values.dns_servers, ["8.8.8.8", "8.8.4.4"])
  }
}
