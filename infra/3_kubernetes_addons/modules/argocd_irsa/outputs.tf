output "iam_role_arn" {
  description = "ARN of IAM role created for IRSA"
  value       = module.irsa.iam_role_arn
}

output "argocd_app_name" {
  description = "Name of the Argo CD application created"
  value       = argocd_application.this.metadata[0].name
} 