terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.11.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.10.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.6.0"
    }
  }
}

data "terraform_remote_state" "aks" {
  backend = "azurerm"
  workspace = var.cluster_tf_workspace

  config = {
    resource_group_name  = "robandpdx-tfstate"
    storage_account_name = "tfstate11610"
    container_name       = "tfstate"
    key                  = "k8sARC.tfstate"
  }
}

data "azurerm_kubernetes_cluster" "cluster" {
  name = data.terraform_remote_state.aks.outputs.cluster_name
  resource_group_name = data.terraform_remote_state.aks.outputs.cluster_resource_group
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
  # username               = data.azurerm_kubernetes_cluster.cluster.kube_config.0.username
  # password               = data.azurerm_kubernetes_cluster.cluster.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}

provider "azurerm" {
  features {}
}