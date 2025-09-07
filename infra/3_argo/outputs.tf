output "argocd_load_balancer_hostname" {
  description = "Private load balancer hostname for ArgoCD UI (internal VPC access only)"
  value       = "Run: kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

output "argocd_access_command_fallback" {
  description = "Alternative: Command to access ArgoCD UI via kubectl port-forward"
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "argocd_admin_password" {
  description = "Initial admin password for ArgoCD"
  value       = "Run: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
  sensitive   = false
}