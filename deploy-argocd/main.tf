resource "kubernetes_namespace" "infra-argocd" {
  metadata {
    annotations = {
      name = var.argocd_namespace
    }

    name = var.argocd_namespace
  }
}


resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  namespace  = var.argocd_namespace
  wait       = false

  values = [
    yamlencode({
      server = {
        
        staticAssets = {
          enabled = true
        }
        resources = {
          requests = {
            cpu    = "50m"
            memory = "64Mi"
          }
          limits = {
            cpu    = "500m"
            memory = "1Gi"
          }
        }
        ingress = {
          enabled = true
          annotations = {
            "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
            "nginx.ingress.kubernetes.io/ssl-passthrough"    = "true"
            "nginx.ingress.kubernetes.io/backend-protocol"   = "HTTPS"
          }
          hosts = [
            var.argocd_url
          ]
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.infra-argocd,
  ]
}
