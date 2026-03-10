variable "nodes" {
  type        = list(string)
  description = "List of Proxmox node names"
  default     = ["pve"]
}

variable "bridge_name" {
  type        = string
  description = "Network bridge name"
  default     = "vmbr1"
}

variable "interface_name" {
  type        = string
  description = "Physical interface name for bridge (e.g., eth1)"
}

variable "bridge_address" {
  type        = string
  description = "IP address for bridge"
}

variable "bridge_netmask" {
  type        = string
  description = "Netmask for bridge"
  default     = "24"
}

variable "vlan_id" {
  type        = number
  description = "VLAN ID (0 = no VLAN)"
  default     = 0
}

variable "gateway" {
  type        = string
  description = "Gateway IP address"
  default     = ""
}

variable "comment" {
  type        = string
  description = "Bridge description/comment"
  default     = ""
}

variable "auto_start" {
  type        = bool
  description = "Auto-start bridge on boot"
  default     = true
}
