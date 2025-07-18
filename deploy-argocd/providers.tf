provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig
  }
}

provider "kubernetes" {
  config_path    = var.kubeconfig
  config_context = var.kubecontext
}

provider "tls" {
  # Configuration options
}
