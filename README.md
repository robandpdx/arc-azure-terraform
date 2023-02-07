# arc-azure-terraform

This terraform template is meant to be deployed to a k8s azure cluster (aks) that was create with [k8s-azure-terraform](https://github.com/robandpdx/k8s-azure-terraform).  

To deploy actions runners and setup ingress for wekhook scaling, [see here](k8s-runners/README.md).  

## Troubleshooting
Sonmetimes the runners get hosed. They are offline and you don't know why. You try to run `terraform destroy` but it times out and fails. I ususally just destroy the k8s cluster and reacreate it. You will need to cleanup the terraform state of this repo. To do so, use the following commands to cleanup the terraform state.
```
terraform state rm "module.prometheus.kubernetes_namespace.monitoring"
terraform state rm "module.cert_manager.kubernetes_namespace.cm"
terraform state rm 'module.actions-runner-controller[0]'
terraform state rm data.terraform_remote_state.cluster
```