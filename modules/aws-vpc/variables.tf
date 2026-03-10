# AWS VPC Module - Network infrastructure
# Variables: VPC CIDR, availability zones, NAT configuration

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for subnets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "enable_nat" {
  type        = bool
  description = "Enable NAT Gateway for private subnets"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
