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
    type: LoadBalancer
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
      service.beta.kubernetes.io/aws-load-balancer-scheme: "internal"
      service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "tcp"
      service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
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