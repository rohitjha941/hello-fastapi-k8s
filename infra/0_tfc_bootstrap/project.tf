# Create project for better organization
resource "tfe_project" "hello_fastapi" {
  organization = data.tfe_organization.main.name
  name         = "hello-fastapi-k8s"
  description  = "FastAPI application on Kubernetes - DevOps showcase project"
}