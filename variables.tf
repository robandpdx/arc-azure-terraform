variable "github_token" {
  description = "Github token for actions-runner-controller"
  type        = string
}

variable "cluster_tf_workspace" {
  description = "k8s-azure-terraform workspace for the cluster"
  type        = string
}