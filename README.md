# Hello FastAPI K8s

This project demonstrates a FastAPI application deployed on AWS EKS with comprehensive infrastructure as code using Terraform.

## Architecture

The infrastructure is organized in layers:

- `0_tfc_bootstrap` - Terraform Cloud workspace management
- `1_ipam` - IP address management (global, run once)
- `2_base` - Base infrastructure (EKS, VPC, OpenSearch)
- `3_argo` - ArgoCD deployment
- `4_kubernetes_addons` - Additional Kubernetes components



The project is organized into two main directories: `app` and `infra`.

- **`app/`**: This directory contains the source code for the Python web application.
    - `main.py`: The main entry point for the FastAPI application.
    - `pyproject.toml`: Defines project metadata and dependencies, managed by `uv`.
    - `.venv/`: A virtual environment for managing Python dependencies locally.

- **`infra/`**: This directory holds the Infrastructure as Code (IaC) definitions using Terraform. The infrastructure is logically separated into layers, with each layer in its own directory.
    - `0_tfc_bootstrap/`: Creates and manages Terraform Cloud workspaces, variable sets, and team access controls.
    - `1_ipam/`: Manages the VPC IP address space (global, run once).
    - `2_base/`: Defines the foundational cloud infrastructure, including the VPC and EKS cluster.
    - `3_argo/`: Sets up ArgoCD for GitOps-based continuous deployment.
    - `4_kubernetes_addons/`: Manages Kubernetes add-ons like external-secrets for secret management.
