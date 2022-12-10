# Actions Runners

1. Create service account (if using containerMode=k8s)
1. Create app credentials for org or enterprise
1. Create secrets in k8s
1. Deploy runners
1. Profit!

## Runner Service Account
To install the runner service account, run
```bash
kubectl apply -f k8s-runners/runner-sa.yaml
```

### Create app credentials for org or PAT for enterprise
Since ARC now supports multitenancy, there are no credentials installed with the ARC helm release. Instead we will create secrects in k8s for each org/enterprise we wish to deploy runner to.  

For orgs and repos, first setup a [GitHub app as described here](https://github.com/actions-runner-controller/actions-runner-controller#deploying-using-github-app-authentication). Then install that GitHub app in your organization.  

For enterprise level runners, you will need to use a PAT rather than an app. See [the ARC docs for details](https://github.com/actions-runner-controller/actions-runner-controller#deploying-using-pat-authentication).  


### Create secrets in k8s
Next create a secret in k8s with the app credentials...
```bash
kubectl create secret generic <secret-name> \
    -n actions-runner-system \
    --from-literal=github_app_id=<appId> \
    --from-literal=github_app_installation_id=<installationId> \
    --from-file=github_app_private_key=<private-key-file-path>
```

Create the secret for an enterprise as follows...
```bash
kubectl create secret generic <secret-name> \
    -n actions-runner-system \
    --from-literal=github_token=<githubPat>
```

Then use the `secret-name` above in your HorizontalRunnerAutoscaler and RunnerDeployment [as described here](https://github.com/actions-runner-controller/actions-runner-controller#multitenancy).

If you want to script the secrets creation in k8s see the script `k8s-runners/create-secrets.sh` as an example. Add the following values to your setenv.sh...  
ARC_ORG_1
ARC_ORG_1_APP_ID  
ARC_ORG_1_INSTALLATION_ID  
ARC_ORG_1_PRIVATE_KEY_FILE_PATH  

Repeat for ORG_2, ORG_3, and ENTERPRISE_1 (pat) as needed.

Then, run the script `k8s-runners/create-secrets.sh`  

### Deploy runners
Once the secrets are in place, edit one of the [runner deploy files](#runner-deploy-files), then deploy it by running...
```bash
kubectl apply -f <file>
```

## Runner Deploy Files
The following files are example. Modify them as needed for your org/enterprise.

- runner.yaml # Deploys a Runner
- runnerdeployment.yaml # Deploys a RunnerDeployment of 2 Runners
- runnerdeployment-pullscaling.yaml # Deploys a [RunnerDeployment](https://github.com/actions-runner-controller/actions-runner-controller#runnerdeployments), [pull driven scaling](https://github.com/actions-runner-controller/actions-runner-controller#pull-driven-scaling)
- runnerdeployment-pullscaling-containermode.yaml # Deploys a [RunnerDeployment](https://github.com/actions-runner-controller/actions-runner-controller#runnerdeployments), [pull driven scaling](https://github.com/actions-runner-controller/actions-runner-controller#pull-driven-scaling), [Runners are k8s containerMode](https://github.com/actions-runner-controller/actions-runner-controller#runner-with-k8s-jobs)
- runnerdeployment-robandpdx-admin-ops.yaml # Deploys a RunnerDeployment of 2 runners to robandpd-admin-ops org
- runnerdeployment-robandpdx-vandelay.yaml # Deploys a RunnerDeployment of 2 runners to robandpd-valdelay org
- runnerdeployment-robandpdx-vandelay.yaml # Deploys a RunnerDeployment of 2 runners to robandpd-volcano org
- runnerdeployment-volcano-coffee.yaml # Deploys a RunnerDeployment of 2 runners to volcano-coffee enterprise

## Webhook driven autoscaling
Deploy the ingress for the webhook server...
```
kubectl apply -f k8s-runners/ingress-wehook.yaml
```
Deploy the webhook driven `HorizontalRunnerAutoscaler` and corresponding `RunnerDeployment`...
```
kubectl apply -f k8s-runners/rd-robandpdx-admin-ops-webhook.yaml
```
Configure a webhook to send `Worflow jobs` events to `http://<your-lb-ip-address>//arc-github-webhook-server`. You can find the ip address to use by looking at your k8s deployment and finding the ingress load balancer ip address.