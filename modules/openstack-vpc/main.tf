terraform {
  required_version = ">= 1.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.50"
    }
  }
}

# Network
resource "openstack_networking_network_v2" "main" {
  name            = var.network_name
  admin_state_up  = true
}

# Subnet
resource "openstack_networking_subnet_v2" "main" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.main.id
  cidr            = var.network_cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

# Router
resource "openstack_networking_router_v2" "main" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
}

# Router Interface
resource "openstack_networking_router_interface_v2" "main" {
  router_id = openstack_networking_router_v2.main.id
  subnet_id = openstack_networking_subnet_v2.main.id
}

# Security Group
resource "openstack_networking_secgroup_v2" "default" {
  name                 = "${var.network_name}-sg"
  description          = "Default security group for ${var.network_name}"
  delete_default_rules = true
}

# Security Group Rules - Allow internal traffic
resource "openstack_networking_secgroup_rule_v2" "ingress_self" {
  direction              = "ingress"
  ethertype              = "IPv4"
  port_range_min         = 0
  port_range_max         = 65535
  protocol               = "tcp"
  remote_group_id        = openstack_networking_secgroup_v2.default.id
  security_group_id      = openstack_networking_secgroup_v2.default.id
}

# Security Group Rules - Allow egress to anywhere
resource "openstack_networking_secgroup_rule_v2" "egress_all" {
  direction         = "egress"
  ethertype         = "IPv4"
  port_range_min    = 0
  port_range_max    = 65535
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.default.id
}

# Data source to get external network ID
data "openstack_networking_network_v2" "external" {
  name = var.external_network_name
}
