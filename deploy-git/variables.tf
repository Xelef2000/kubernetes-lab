variable "kubeconfig" {
  type        = string
  description = "Path to the kubeconfig file."
}

variable "kubecontext" {
  type        = string
  description = "The context to use from the kubeconfig file."
}

variable "git_namespace" {
  type        = string
  description = "The Kubernetes namespace to deploy the Git server into."
}

variable "git_release_name" {
  type        = string
  description = "The Helm release name for the deployment."
}

variable "git_url" {
  type        = string
  description = "The fully qualified domain name for the Ingress host."
}

variable "ingress_class_name" {
  type        = string
  description = "The class name for the Ingress controller."
  default     = "nginx"
}

variable "repos" {
  type = list(object({
    name      = string
    init_from = optional(string, "")
  }))
  description = "A list of repositories to create."
  default     = []
}