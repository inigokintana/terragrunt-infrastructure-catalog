include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//modules/aws-eks?ref=${values.version}"
  #source = "${get_repo_root()}/terragrunt-infrastructure-catalog/modules/aws-eks"
  #source = "../../terragrunt-infrastructure-catalog/modules/aws-eks"
  #source = "/home/inigokintana/IaC-SovereignCloudAI/terragrunt-infrastructure-catalog/modules/aws-eks"

}

dependency "vpc" {
  #config_path = values.vpc_path
  config_path = "../vpc"
  mock_outputs = {
    vpc_id             = "vpc-12345678"
    private_subnet_ids = ["subnet-12345678", "subnet-87654321"]
  }
}

inputs = {
  cluster_name             = values.cluster_name
  kubernetes_version       = try(values.kubernetes_version, "1.28")
  vpc_id                   = dependency.vpc.outputs.vpc_id
  subnet_ids               = dependency.vpc.outputs.private_subnet_ids
  node_group_desired_size  = try(values.node_group_desired_size, 2)
  node_group_min_size      = try(values.node_group_min_size, 1)
  node_group_max_size      = try(values.node_group_max_size, 4)
  node_instance_type       = try(values.node_instance_type, "t3.medium")
  tags                     = try(values.tags, {})
}
