variable "kubernetes_ca_bundle" {
  type        = string
  description = "Kubernetes cluster CA Bundle"
}

variable "kubernetes_token_reviewer_jwt" {
  type        = string
  description = "Kubernetes cluster Token Reviewer JWT"
}

variable "kubernetes_cluster_api" {
  type        = string
  description = "Kubernetes cluster API endpoint"
}