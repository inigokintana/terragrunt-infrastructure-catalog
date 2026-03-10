locals {
  stack_name = "eks-foundation"
  cluster_name = "${local.stack_name}-${values.environment}"
}

unit "vpc" {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//units/aws-vpc?ref=${values.version}"
  path   = "vpc"

  values = {
    version              = values.version
    vpc_cidr             = values.vpc_cidr
    availability_zones   = try(values.availability_zones, ["us-east-1a", "us-east-1b"])
    enable_nat           = try(values.enable_nat, true)
    tags = {
      Stack       = local.stack_name
      Environment = values.environment
      ManagedBy   = "Terragrunt"
    }
  }
}

unit "eks" {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//units/aws-eks?ref=${values.version}"
  path   = "eks"

  values = {
    version                  = values.version
    cluster_name             = values.cluster_name
    kubernetes_version       = try(values.kubernetes_version, "1.28")
    vpc_path                 = unit.vpc.path
    node_group_desired_size  = try(values.node_group_desired_size, 2)
    node_group_min_size      = try(values.node_group_min_size, 1)
    node_group_max_size      = try(values.node_group_max_size, 4)
    node_instance_type       = try(values.node_instance_type, "t3.medium")
    tags = {
      Stack       = local.stack_name
      Environment = values.environment
      ManagedBy   = "Terragrunt"
    }
  }
}
