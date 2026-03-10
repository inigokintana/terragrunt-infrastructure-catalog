include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//modules/aws-vpc?ref=${values.version}"
  #source = "${get_repo_root()}/terragrunt-infrastructure-catalog/modules/aws-vpc"
  #source = "../../terragrunt-infrastructure-catalog/modules/aws-vpc"
  #source = "/home/inigokintana/IaC-SovereignCloudAI/terragrunt-infrastructure-catalog/modules/aws-vpc"
}

inputs = {
  vpc_cidr             = values.vpc_cidr
  availability_zones   = try(values.availability_zones, ["us-east-1a", "us-east-1b"])
  enable_nat           = try(values.enable_nat, true)
  tags                 = try(values.tags, {})
}
