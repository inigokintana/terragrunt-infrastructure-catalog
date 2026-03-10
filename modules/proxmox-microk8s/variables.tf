variable "proxmox_node" {
  type        = string
  description = "Proxmox node name where VMs will be deployed"
}

variable "cluster_name" {
  type        = string
  description = "Microk8s cluster name"
}

variable "vm_count" {
  type        = number
  description = "Number of VMs to deploy"
  default     = 3
}

variable "vm_id_start" {
  type        = number
  description = "Starting VM ID"
  default     = 100
}

variable "cpu_cores" {
  type        = number
  description = "Number of CPU cores per VM"
  default     = 2
}

variable "memory_mb" {
  type        = number
  description = "Memory in MB per VM"
  default     = 2048
}

variable "disk_size_gb" {
  type        = number
  description = "Disk size in GB per VM"
  default     = 20
}

variable "template_name" {
  type        = string
  description = "VM template name (e.g., ubuntu-22.04)"
}

variable "bridge_name" {
  type        = string
  description = "Network bridge to attach VMs to"
  default     = "vmbr0"
}

variable "start_index" {
  type        = number
  description = "Starting IP index (e.g., 10 for 192.168.1.10)"
  default     = 10
}

variable "gateway_ip" {
  type        = string
  description = "Gateway IP address"
  default     = "192.168.1.1"
}

variable "subnet_mask" {
  type        = string
  description = "Subnet mask (e.g., 24)"
  default     = "24"
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS server IPs"
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
