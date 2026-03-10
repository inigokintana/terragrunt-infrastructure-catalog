terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.9"
    }
  }
}

#https://search.opentofu.org/provider/bpg/proxmox/latest Better manteined provider
# terraform {
#   required_providers {
#     proxmox = {
#       source = "bpg/proxmox"
#       version = "0.98.1"
#     }
#   }
# }

# Cloud-init script for Microk8s deployment
locals {
  cloud_init_script = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    cluster_name = var.cluster_name
    dns_servers  = join(" ", var.dns_servers)
  }))
}

# Deploy Microk8s VMs
resource "proxmox_vm_qemu" "microk8s" {
  count       = var.vm_count
  vmid        = var.vm_id_start + count.index
  name        = "${var.cluster_name}-vm-${count.index + 1}"
  target_node = var.proxmox_node
  
  clone            = var.template_name
  full_clone       = true
  
  os_type = "cloud-init"
  
  cores     = var.cpu_cores
  memory    = var.memory_mb
  
  disk {
    type     = "virtio"
    storage  = "local-lvm"
    size     = "${var.disk_size_gb}G"
    slot     = 0
  }
  
  network {
    id       = 0
    model    = "virtio"
    bridge   = var.bridge_name
  }
  
  # Cloud-init configuration
  ipconfig0 = "ip=192.168.1.${var.start_index + count.index}/${var.subnet_mask},gw=${var.gateway_ip}"
  nameserver = var.dns_servers[0]
  
  ciuser     = "ubuntu"
  cipassword = "ubuntu"
  
  # Enable serial console
  serial {
    id   = 0
    type = "socket"
  }
  
  lifecycle {
    ignore_changes = [desc]
  }
  
  tags = join(";", [
    var.cluster_name,
    "microk8s",
    var.tags != {} ? join(";", [for k, v in var.tags : "${k}=${v}"]) : ""
  ])
}

#bpg/proxmox provider
# resource "proxmox_virtual_environment_vm" "microk8s" {
#   name      = "microk8s"
#   node_name = "your-node"

#   cpu {
#     cores = 2
#   }

#   memory {
#     dedicated = 2048
#   }

#   disk {
#     datastore_id = "local-lvm"
#     size         = 20
#     interface    = "virtio0"
#   }

#   network_device {
#     bridge = "vmbr0"
#   }
# }

# Wait for VMs to be ready
resource "time_sleep" "wait_for_vms" {
  depends_on      = [proxmox_vm_qemu.microk8s]
  create_duration = "30s"
}
