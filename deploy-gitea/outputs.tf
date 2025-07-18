# outputs.tf

output "gitea_service_url" {
  description = "The internal URL of the Gitea service (for internal cluster access)"
  value       = "http://${helm_release.gitea.name}.${helm_release.gitea.namespace}.svc.cluster.local:3000/"
}

output "gitea_admin_username" {
  description = "The Gitea admin username"
  value       = var.gitea_admin_username
}

output "gitea_admin_password" {
  description = "The Gitea admin password (sensitive)"
  value       = var.gitea_admin_password
  sensitive   = true
}


output "gitea_internal_service_url" {
  description = "Internal cluster URL for Gitea (for ArgoCD access)"
  value       = "http://${var.gitea_release_name}-gitea-http.${var.gitea_namespace}.svc.cluster.local:3000"
}

output "gitea_ssh_service" {
  description = "Internal SSH service for Git operations"
  value       = "${var.gitea_release_name}-gitea-ssh.${var.gitea_namespace}.svc.cluster.local:22"
}


output "gitea_namespace" {
  description = "Kubernetes namespace where Gitea is deployed"
  value       = kubernetes_namespace.gitea.metadata[0].name
}

output "gitea_release_name" {
  description = "Helm release name for Gitea"
  value       = helm_release.gitea.name
}