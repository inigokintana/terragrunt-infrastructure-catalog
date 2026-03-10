include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  stack_name = "openshift-foundation"
}

unit "vpc" {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//units/openstack-vpc?ref=${values.version}"
  path   = "vpc"

  values = {
    version               = values.version
    network_name          = values.network_name
    network_cidr          = try(values.network_cidr, "10.0.0.0/16")
    subnet_name           = values.subnet_name
    router_name           = values.router_name
    dns_nameservers       = try(values.dns_nameservers, ["8.8.8.8", "8.8.4.4"])
    external_network_name = try(values.external_network_name, "public")
    tags = {
      Stack     = local.stack_name
      ManagedBy = "Terragrunt"
    }
  }
}

unit "openshift" {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//units/openstack-openshift?ref=${values.version}"
  path   = "openshift"

  values = {
    version             = values.version
    cluster_name        = values.cluster_name
    base_image_name     = try(values.base_image_name, "RHEL-9")
    master_flavor_name  = try(values.master_flavor_name, "m1.large")
    worker_flavor_name  = try(values.worker_flavor_name, "m1.xlarge")
    vpc_path            = unit.vpc.path
    volume_size         = try(values.volume_size, 50)
    tags = {
      Stack     = local.stack_name
      ManagedBy = "Terragrunt"
    }
  }
}
