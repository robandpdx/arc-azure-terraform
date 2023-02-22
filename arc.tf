
module "prometheus" {
  source = "git::https://github.com/robandpdx/tf-modules.git//kube-prometheus-stack"
}

module "cert_manager" {
  source = "git::https://github.com/robandpdx/tf-modules.git//cert-manager"
}

module "actions-runner-controller" {
  source = "git::https://github.com/robandpdx/tf-modules.git//actions-runner-controller?ref=arc2"
  depends_on = [
    module.cert_manager,
  ]
  github_token = var.github_token
}
