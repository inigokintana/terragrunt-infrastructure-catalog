include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//modules/openstack-openshift?ref=${values.version}"
}

dependency "vpc" {
  #config_path = values.vpc_path
  config_path = "../vpc"
  mock_outputs = {
    network_id        = "net-12345678"
    security_group_id = "sg-12345678"
  }
}

inputs = {
  cluster_name        = values.cluster_name
  base_image_name     = try(values.base_image_name, "RHEL-9")
  master_flavor_name  = try(values.master_flavor_name, "m1.large")
  worker_flavor_name  = try(values.worker_flavor_name, "m1.xlarge")
  network_id          = dependency.vpc.outputs.network_id
  security_group_id   = dependency.vpc.outputs.security_group_id
  volume_size         = try(values.volume_size, 50)
  tags                = try(values.tags, {})
}
