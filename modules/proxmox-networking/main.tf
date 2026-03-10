terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.9"
    }
  }
}

# Note: Proxmox provider has limited network bridge management.
# This module documents network configuration that should be pre-configured
# or managed via Proxmox API directly.

# Local data file to track bridge configuration
resource "local_file" "network_config" {
  filename = "${path.module}/.network-config.json"
  content = jsonencode({
    bridge_name     = var.bridge_name
    interface       = var.interface_name
    address         = var.bridge_address
    netmask         = var.bridge_netmask
    vlan_id         = var.vlan_id
    gateway         = var.gateway
    comment         = var.comment
    nodes           = var.nodes
  })
}

# Output file with network setup instructions
resource "local_file" "setup_instructions" {
  filename = "${path.module}/.setup-instructions.md"
  content = templatefile("${path.module}/setup-template.md", {
    bridge_name   = var.bridge_name
    interface     = var.interface_name
    address       = var.bridge_address
    netmask       = var.bridge_netmask
    vlan_id       = var.vlan_id
    gateway       = var.gateway
    comment       = var.comment
    nodes         = join(", ", var.nodes)
  })
}
