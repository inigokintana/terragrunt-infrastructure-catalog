# Proxmox Network Setup Instructions

This file provides instructions for setting up the network bridge on Proxmox nodes.

## Bridge Configuration

- **Bridge Name**: ${bridge_name}
- **Physical Interface**: ${interface}
- **Bridge Address**: ${address}/${netmask}
- **VLAN ID**: ${vlan_id}
- **Gateway**: ${gateway}
- **Nodes**: ${nodes}

## Manual Setup (Proxmox Web UI)

1. Navigate to **Datacenter** > **Network** > **Create** > **Linux Bridge**
2. Configure:
   - Name: `${bridge_name}`
   - VLAN aware: No (unless using VLAN ${vlan_id})
   - Autostart: Yes
3. Save and apply network changes

## Edit /etc/network/interfaces (Manual)

Add to each Proxmox node's network configuration:

\`\`\`
auto ${bridge_name}
iface ${bridge_name} inet static
    bridge-ports ${interface}
    bridge-stp off
    bridge-fd 0
    address ${address}
    netmask 255.255.255.${netmask}
    gateway ${gateway}
\`\`\`

## Terraform Note

The Telmate/proxmox provider has limited network management capabilities.
Network bridges should be pre-configured on Proxmox nodes before VM deployment.
This module serves as documentation and configuration tracking.
