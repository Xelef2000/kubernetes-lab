resource "kubernetes_namespace" "git_ns" {
  metadata {
    name = var.git_namespace
  }
}

resource "helm_release" "pygitserver" {
  name       = var.git_release_name
  repository = "https://xelef2000.github.io/PyGitServer"
  chart      = "pygitserver"
  version    = "1.3.8"
  namespace  = kubernetes_namespace.git_ns.metadata[0].name

  values = [
    yamlencode({
      ingress = {
        enabled     = true
        className   = var.ingress_class_name
        hosts = [{
          host = var.git_url
          paths = [{ path = "/", pathType = "ImplementationSpecific" }]
        }]
      }
      repositories = var.repos
      persistence = {
        enabled = true
        size    = "1Gi"
      }
    })
  ]

  depends_on = [kubernetes_namespace.git_ns]
}
