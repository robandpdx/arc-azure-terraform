INSTALLATION_NAME=${ARC_ENTERPRISE_1}
NAMESPACE=${ARC_ENTERPRISE_1}
GITHUB_CONFIG_URL="https://github.com/enterprises/volcano-coffee"
GITHUB_PAT=${ARC_ENTERPRISE_1_PAT}
helm install "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${GITHUB_PAT}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/auto-scaling-runner-set --version 0.1.0