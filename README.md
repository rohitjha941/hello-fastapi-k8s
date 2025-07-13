# Hello Flask K8s

This project shows how I will implement the following features:

- **Infrastructure as Code (IaC)**: Multi-layered Terraform setup for AWS EKS, VPC, and supporting services
- **Container Orchestration**: Kubernetes deployment with auto-scaling using Karpenter and spot instances
- **GitOps & CI/CD**: ArgoCD for continuous deployment with GitHub Actions pipeline
- **Microservices Architecture**: FastAPI application with health checks and monitoring endpoints
- **Secret Management**: External Secrets Operator for secure credential handling
- **Monitoring & Observability**: Prometheus and Grafana integration for metrics and alerting
- **High Availability**: Multi-AZ deployment with load balancing and auto-scaling
- **Database Integration**: PostgreSQL with connection pooling and optimization
- **API Development**: RESTful APIs with proper error handling and response optimization
- **Testing Strategy**: Unit testing, integration testing, and automated testing pipelines
- **Security**: RBAC, network policies, and secure container practices
- **Centralized Logging**: Fluentd integration for log aggregation and analysis
- **Preview Environments**: Short-lived environments for feature testing and development

This document outlines the structure, current implementation, and future plans for the `hello-flask-k8s` project.

## 1. Project Structure

The project is organized into two main directories: `app` and `infra`.

- **`app/`**: This directory contains the source code for the Python web application.
    - `main.py`: The main entry point for the FastAPI application.
    - `pyproject.toml`: Defines project metadata and dependencies, managed by `uv`.
    - `.venv/`: A virtual environment for managing Python dependencies locally.

- **`infra/`**: This directory holds the Infrastructure as Code (IaC) definitions using Terraform. The infrastructure is logically separated into layers, with each layer in its own directory.
    - `0_ipam/`: Manages the VPC IP address space.
    - `1_base/`: Defines the foundational cloud infrastructure, including the VPC and EKS cluster.
    - `2_argo/`: Sets up ArgoCD for GitOps-based continuous deployment.
    - `3_kubernetes_addons/`: Manages Kubernetes add-ons like external-secrets for secret management.

## 2. Current Implementation

The project foundation demonstrates enterprise-grade infrastructure practices:

### Infrastructure as Code (IaC)
- **Multi-layered Terraform Architecture**: Organized into logical layers for maintainability and reusability
  - `0_ipam/`: VPC IP address management with proper CIDR allocation
  - `1_base/`: Core AWS infrastructure including VPC, subnets, and EKS cluster
  - `2_argo/`: ArgoCD deployment for GitOps workflow
  - `3_kubernetes_addons/`: External Secrets Operator and other essential add-ons

### Application Foundation
- **FastAPI Microservice**: Modern Python web framework with automatic API documentation
- **Dependency Management**: Using `uv` for fast Python package management
- **Modular Structure**: Clean separation between application code and infrastructure

### Container Orchestration Setup
- **AWS EKS Cluster**: Production-ready Kubernetes cluster with proper networking
- **ArgoCD Integration**: GitOps-based deployment pipeline foundation
- **External Secrets**: Secure credential management using AWS Secrets Manager

## 3. Implementation Roadmap

### Phase 1: Application Development & Containerization
- **Enhanced FastAPI Application**:
  - Health check endpoints (`/health`, `/readiness`) for Kubernetes probes
  - Metrics endpoints for Prometheus integration
  - Structured logging with correlation IDs
  - API versioning and proper error handling
  - Database integration with connection pooling
  
- **Containerization**:
  - Multi-stage Dockerfile for optimized image size
  - Security scanning and vulnerability management
  - Amazon ECR integration for container registry
  - Image signing and verification

### Phase 2: CI/CD Pipeline Implementation
- **GitHub Actions Workflow**:
  - Automated testing (unit, integration, E2E)
  - Code quality checks (linting, security scanning)
  - Docker image building and pushing
  - Terraform plan/apply automation
  - Preview environment creation for feature branches

- **Testing Strategy**:
  - Unit tests with >90% coverage
  - Integration tests for API endpoints
  - Infrastructure testing with Terratest
  - Performance testing and load testing

### Phase 3: Kubernetes Deployment & Auto-scaling
- **Kubernetes Manifests**:
  - Deployment with resource limits and requests
  - Horizontal Pod Autoscaler (HPA) configuration
  - Service and Ingress for traffic management
  - Network policies for security
  - RBAC configuration

- **Karpenter Integration**:
  - Node auto-scaling with spot instances
  - Cost optimization through right-sizing
  - Multi-AZ deployment for high availability

### Phase 4: Database & Data Layer
- **PostgreSQL Integration**:
  - Amazon RDS with Multi-AZ deployment
  - Connection pooling with PgBouncer
  - Database migrations and schema management
  - Performance optimization and indexing
  - Backup and disaster recovery

### Phase 5: Monitoring & Observability
- **Prometheus Stack**:
  - Application metrics collection
  - Custom business metrics
  - Alerting rules and notification channels
  - Long-term storage with Thanos

- **Grafana Dashboards**:
  - Application performance monitoring
  - Infrastructure metrics visualization
  - SLA/SLO tracking dashboards
  - Cost monitoring and optimization

### Phase 6: Logging & Security
- **Centralized Logging**:
  - Fluentd for log aggregation
  - Elasticsearch for log storage and search
  - Kibana for log visualization
  - Log retention and archival policies

- **Security Implementation**:
  - Pod Security Standards enforcement
  - Network segmentation with Calico
  - Secrets rotation automation
  - Vulnerability scanning and compliance

### Phase 7: Advanced Features
- **Preview Environments**:
  - Automated environment provisioning
  - Feature branch deployments
  - Environment cleanup automation
  - Cost optimization for ephemeral environments

- **Advanced Deployment Strategies**:
  - Blue-green deployments
  - Canary releases with traffic splitting
  - Rollback automation
  - Chaos engineering practices
