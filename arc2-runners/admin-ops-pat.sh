INSTALLATION_NAME=${ARC_ORG_1}
NAMESPACE=${ARC_ORG_1}
GITHUB_CONFIG_URL="https://github.com/robandpdx-admin-ops"
GITHUB_PAT=${ARC_ENTERPRISE_1_PAT}
helm install "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${GITHUB_PAT}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/auto-scaling-runner-set --version 0.1.0