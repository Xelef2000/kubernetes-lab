resource "kubernetes_namespace" "gitea" {
  metadata {
    name = var.gitea_namespace
    labels = {
      name = var.gitea_namespace
    }
  }
}

# Create a secret for Gitea admin credentials
resource "kubernetes_secret" "gitea_admin" {
  metadata {
    name      = "gitea-admin-secret"
    namespace = kubernetes_namespace.gitea.metadata[0].name
  }

  data = {
    username = var.gitea_admin_username
    password = var.gitea_admin_password
    email    = var.gitea_admin_email
  }

  type = "Opaque"
}

# Deploy Gitea using Helm
resource "helm_release" "gitea" {
  name       = var.gitea_release_name
  repository = "https://dl.gitea.com/charts/"
  chart      = "gitea"
  namespace  = kubernetes_namespace.gitea.metadata[0].name
  version    = "10.4.0" # You can update this to the latest version

  # Wait for the deployment to be ready
  wait          = true
  wait_for_jobs = true
  timeout       = 600

  # Gitea configuration values
  values = [
    yamlencode({
      # Gitea configuration
      gitea = {
        admin = {
          username = var.gitea_admin_username
          password = var.gitea_admin_password
          email    = var.gitea_admin_email
        }
        config = {
          APP_NAME = "Gitea: Git with a cup of tea"
          RUN_MODE = "prod"
          
          server = {
            DOMAIN           = var.gitea_url
            HTTP_PORT        = 3000
            ROOT_URL         = "http://${var.gitea_url}"
            DISABLE_SSH      = false
            SSH_PORT         = 22
            LFS_START_SERVER = true
          }
          
          database = {
            DB_TYPE = "sqlite3"
            PATH    = "/data/gitea/gitea.db"
          }
          
          repository = {
            ROOT = "/data/git/repositories"
          }
          
          security = {
            INSTALL_LOCK = true
          }
          
          service = {
            DISABLE_REGISTRATION = false
            ENABLE_NOTIFY_MAIL   = false
          }
        }
      }

      # Persistence configuration
      persistence = {
        enabled      = true
        size         = "5Gi"
        storageClass = "standard" # Adjust based on your cluster's storage classes
        accessModes  = ["ReadWriteOnce"]
      }

      # Service configuration
      service = {
        http = {
          type = "ClusterIP"
          port = 3000
        }
        ssh = {
          type = "ClusterIP"
          port = 22
        }
      }

      # Resource limits
      resources = {
        limits = {
          cpu    = "1000m"
          memory = "1Gi"
        }
        requests = {
          cpu    = "100m"
          memory = "128Mi"
        }
      }

      # Security context
      podSecurityContext = {
        fsGroup = 1000
      }

      securityContext = {
        runAsUser  = 1000
        runAsGroup = 1000
      }

      # Ingress configuration
      ingress = {
        enabled = true
        className = "nginx" # Change to your ingress controller class
        annotations = {
          "nginx.ingress.kubernetes.io/rewrite-target" = "/"
          "nginx.ingress.kubernetes.io/ssl-redirect" = "false"
        }
        hosts = [
          {
            host = var.gitea_url
            paths = [
              {
                path = "/"
                pathType = "Prefix"
              }
            ]
          }
        ]
        # Uncomment for TLS
        # tls = [
        #   {
        #     secretName = "gitea-tls"
        #     hosts = [var.gitea_url]
        #   }
        # ]
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.gitea,
    kubernetes_secret.gitea_admin
  ]
}
