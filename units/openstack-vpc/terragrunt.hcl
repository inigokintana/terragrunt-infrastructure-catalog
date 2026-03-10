include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/inigokintana/terragrunt-infrastructure-catalog.git//modules/openstack-vpc?ref=${values.version}"
}

inputs = {
  network_name         = values.network_name
  network_cidr         = try(values.network_cidr, "10.0.0.0/16")
  subnet_name          = values.subnet_name
  dns_nameservers      = try(values.dns_nameservers, ["8.8.8.8", "8.8.4.4"])
  router_name          = values.router_name
  external_network_name = try(values.external_network_name, "public")
  tags                 = try(values.tags, {})
}
