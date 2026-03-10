terraform {
  required_version = ">= 1.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.50"
    }
  }
}

# Data source to get base image
data "openstack_images_image_v2" "base" {
  name            = var.base_image_name
  most_recent     = true
}

# Cinder volume for persistent storage (future use by Openshift)
resource "openstack_blockstorage_volume_v3" "master_storage" {
  count       = 3  # 3 master nodes
  name        = "${var.cluster_name}-master-${count.index + 1}-vol"
  size        = var.volume_size
  description = "Storage for Openshift master node ${count.index + 1}"
}

resource "openstack_blockstorage_volume_v3" "worker_storage" {
  count       = 2  # 2 worker nodes
  name        = "${var.cluster_name}-worker-${count.index + 1}-vol"
  size        = var.volume_size
  description = "Storage for Openshift worker node ${count.index + 1}"
}

# Keypair for SSH access
resource "openstack_compute_keypair_v2" "cluster" {
  name = "${var.cluster_name}-key"
}

# Master node VMs (placeholders for manual Openshift deployment or operator)
resource "openstack_compute_instance_v2" "master" {
  count             = 3
  name              = "${var.cluster_name}-master-${count.index + 1}"
  image_id          = data.openstack_images_image_v2.base.id
  flavor_name       = var.master_flavor_name
  key_pair          = openstack_compute_keypair_v2.cluster.name
  network {
    uuid = var.network_id
  }
  security_groups = [var.security_group_id]
}

# Worker node VMs
resource "openstack_compute_instance_v2" "worker" {
  count             = 2
  name              = "${var.cluster_name}-worker-${count.index + 1}"
  image_id          = data.openstack_images_image_v2.base.id
  flavor_name       = var.worker_flavor_name
  key_pair          = openstack_compute_keypair_v2.cluster.name
  network {
    uuid = var.network_id
  }
  security_groups = [var.security_group_id]
}

# Floating IPs for API access
resource "openstack_networking_floatingip_v2" "api" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "api" {
  floating_ip = openstack_networking_floatingip_v2.api.address
  instance_id = openstack_compute_instance_v2.master[0].id
  fixed_ip    = openstack_compute_instance_v2.master[0].access_ip_v4
}
