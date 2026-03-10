include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/proxmox-networking"
}

inputs = {
  nodes              = try(values.nodes, ["pve"])
  bridge_name        = values.bridge_name
  interface_name     = values.interface_name
  bridge_address     = values.bridge_address
  bridge_netmask     = try(values.bridge_netmask, "24")
  vlan_id            = try(values.vlan_id, 0)
  gateway            = try(values.gateway, "")
  comment            = try(values.comment, "")
  auto_start         = try(values.auto_start, true)
}
