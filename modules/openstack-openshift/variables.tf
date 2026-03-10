variable "cluster_name" {
  type        = string
  description = "Openshift cluster name"
}

variable "base_image_name" {
  type        = string
  description = "Base image name for VMs (e.g., RHEL, CentOS)"
  default     = "RHEL-9"
}

variable "master_flavor_name" {
  type        = string
  description = "VM flavor for master nodes"
  default     = "m1.large"
}

variable "worker_flavor_name" {
  type        = string
  description = "VM flavor for worker nodes"
  default     = "m1.xlarge"
}

variable "network_id" {
  type        = string
  description = "Network ID for VM deployment"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for VMs"
}

variable "volume_size" {
  type        = number
  description = "Storage volume size in GB"
  default     = 50
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
