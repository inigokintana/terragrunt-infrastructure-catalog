# Terragrunt Infrastructure Catalog

Stateless, reusable Terraform/OpenTofu modules and Terragrunt units for multicloud infrastructure provisioning (AWS, OpenStack, Proxmox).

## Structure

- **modules/** - Pure Terraform/OpenTofu modules (stateless, cloud-specific blueprints)
- **units/** - Terragrunt units wrapping modules with `values.*` pattern for reusability
- **stacks/** - Pre-configured unit collections (foundation stacks for VPC + K8s)
- **examples/** - Standalone examples for modules (pure Terraform) and units (Terragrunt)
- **test/** - Terratest cases for module validation

## Modules

| Module | Cloud | Purpose |
|--------|-------|---------|
| aws-vpc | AWS | VPC, subnets, NAT, routing |
| aws-eks | AWS | EKS cluster + worker nodes |
| openstack-vpc | OpenStack | Networks, subnets, routers |
| openstack-openshift | OpenStack | Openshift prerequisites + templates |
| proxmox-networking | Proxmox | Bridges, VLANs, clustering |
| proxmox-microk8s | Proxmox | VM templates, cloud-init for Microk8s |

## Usage

### Install Dependencies

```bash
brew install terraform terragrunt
# or on Linux:
# apt-get install terraform terragrunt
```

### Generate Stacks (from infrastructure-live repo)

```bash
cd infrastructure-live-aws/prod/us-east-1/eks-foundation-stack
terragrunt stack generate
```

### Plan & Apply

```bash
terragrunt stack run plan
terragrunt stack run apply
```

## Versioning

Uses Git tags for releases: `v0.1.0`, `v0.2.0`, etc.

Infrastructure-live repos reference catalog versions via:
```hcl
values = {
  version = "v0.1.0"  # Pin catalog version
}
```

## License

Internal use - SovereignCloudAI IaC Strategy
