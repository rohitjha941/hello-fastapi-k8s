output "argocd_access_command" {
  description = "Command to access ArgoCD UI via kubectl port-forward"
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "argocd_url_after_port_forward" {
  description = "URL for ArgoCD UI after port-forwarding"
  value       = "https://localhost:8080"
}

output "argocd_admin_password" {
  description = "Initial admin password for ArgoCD"
  value       = "Run: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
  sensitive   = false
}