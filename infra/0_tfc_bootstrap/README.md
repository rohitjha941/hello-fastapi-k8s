# Terraform Cloud Bootstrap

This module manages Terraform Cloud workspaces and configuration for the hello-fastapi-k8s project.

## Overview

This creates a complete Terraform Cloud setup including:
- Organization project
- Workspaces for each layer and environment
- Variable sets for AWS credentials and common configurations
- Run triggers for dependent workspaces
- Team access controls

## Prerequisites

1. Terraform Cloud account and organization
2. GitHub OAuth connection configured in TFC
3. AWS credentials for TFC to use

## Usage

1. First, create the bootstrap workspace manually or via CLI:
```bash
cd infra/0_tfc_bootstrap
terraform login
terraform workspace new tfc-bootstrap
```

2. Configure variables:
```bash
# Required variables
export TF_VAR_tfc_organization="your-org"
export TF_VAR_aws_access_key_id="AKIA..."
export TF_VAR_aws_secret_access_key="secret..."
export TF_VAR_github_repository="yourusername/hello-flask-k8s"
```

3. Run terraform:
```bash
terraform init
terraform plan
terraform apply
```

## Workspace Structure

The following workspaces will be created:

- `ipam-global` - IP Address Management (shared across all environments)
- `base-{dev,staging,prod}` - Base infrastructure (VPC, EKS)
- `argo-{dev,staging,prod}` - ArgoCD deployment
- `addons-{dev,staging,prod}` - Kubernetes addons

## Features

- **Auto-apply**: Enabled for dev workspaces only
- **Run triggers**: Dependent workspaces trigger automatically
- **Branch protection**: 
  - Dev/staging workspaces use respective branches
  - Prod workspaces use main branch
- **Access control**: Developers have write access to dev/staging, plan-only for prod

## Customization

Edit `main.tf` to:
- Add more layers or environments
- Change auto-apply settings
- Modify team permissions
- Add notification channels (Slack, email, webhooks)