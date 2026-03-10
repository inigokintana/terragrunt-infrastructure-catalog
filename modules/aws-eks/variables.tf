variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the cluster"
  default     = "1.28"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the cluster will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the cluster"
}

variable "node_group_desired_size" {
  type        = number
  description = "Desired number of worker nodes"
  default     = 2
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "node_group_max_size" {
  type        = number
  description = "Maximum number of worker nodes"
  default     = 4
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for worker nodes"
  default     = "t3.medium"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
