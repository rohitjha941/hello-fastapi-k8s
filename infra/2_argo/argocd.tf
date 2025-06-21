resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.1.1"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  values = [<<EOF
server:
  service:
    type: ClusterIP
  ingress:
    enabled: false
  extraArgs:
    - --insecure
configs:
  cm:
    timeout.reconciliation: 180s
EOF
  ]

  depends_on = [
    kubernetes_namespace.argocd
  ]
}