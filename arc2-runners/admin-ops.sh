# Using a GitHub App
INSTALLATION_NAME=${ARC_ORG_1}
NAMESPACE=${ARC_ORG_1}
GITHUB_CONFIG_URL="https://github.com/robandpdx-admin-ops" 
GITHUB_APP_ID=${ARC_ORG_1_APP_ID}
GITHUB_APP_INSTALLATION_ID="-----BEGIN RSA PRIVATE KEY-----MIIEpQIBAAKCAQEAtecwCPmF3cDM/lH4LsvWyqwydOeMqp8M7j4dm7JQ0B0vOMX6qubEss8IhRxW2iicYAF/nOEvOPDqsNg2lMh0By7ZsbOZqTT5FTohUUmRnBzaiyaR/OUoI+HbDdElG9Uy58zgCavkRdo7YHRlq2FvEa9hYTNpfg+7sEtQRpsoXt+QFr0y1ZGSp9fv6uxW2XTkuWP8S/kictY1scsjhw10YQmyK5K/xKOFNCC9/wD/bwgdZqEzt0hdnl+pwwKWNi80A5mbFBQCm6XG++yNbjZ+CYwyOS2XiAWBXq1o7kaF2M9pm9ZVs+e6aS7+zclwz45yCSPL+mtZJ1oxw986UJGMfQIDAQABAoIBAQCeR7aSeJy1Ioi9WxH7lj8mR8P32WubI56ax833pqePD3YBjrPZdcf+Vwvw14HzfpbjKyqhlYgDog51Jw4HVI0xmuCuMbspcwCyKczH8J4VGz5HCp7JUZUl8+cqFKyXlWIgNTNU9w9AgO5dtaqp/7QnzVWMwLGwkXwdoMsPRP9R3Pry2ItFWvPYBLGK70tKMJxHMlvlaFbMGt28NbufQyeIOKSA+bgrGLAHdMZj7ehr13qp9ad+BI9VlaeNJixtkjdLXt9ve7U2dO83SoNFFk3WTIvXUX4KCmRaGjbl25wUEGAr7RACGL2OmAMuYKqbA6RjabceL2rFSM74jIi4PWV5AoGBANmaFmISbHCfFlxyWEm8iqM/cK6bvCH6aezVAXbSjkAXBWzwyfNInQp3Mi9Q1CL/Bqx/5mnx4+9ZD5Fl//O2whAUqzBGPZcmgia3Wl1CxpUyFxKhKnIQ+nbIjuQmyHHHwg9G4TUs3f+F3AJljT2sZDWh8wGSXaCImCy+C70G791vAoGBANYAcn9/5Wh7qKdzFG6KGfJcI67V2Pti+/K10vfN+VeheV8297JTrDcFx1culRkox96Xqi4/1sXoaxaHM2qE0cZhcxY57pGEH5ZWNvl3YMbfsF74/+GQUwKX69u3Zqd088ykm6YlsPZolTq0zaUQsgS0oORfULRVlg0rRKNTUZbTAoGAAZmyhHIiPgnNfkyQ/anXUzAKQh5/GbjfwpAmfJs71JjWv2Bd+94S2Zra0aJEjSVXBTnDlg/jX0VGaglYApDbiIa+Y5KArXXpCyPaFEmDcGF37fkleMVLMkhzVJY8bynK8ZXR3jRARbrUTWg1y7hS3FoekWpkKeQXSmzzZSaB6R0CgYEA0SzwvfWKjF1K1hojX4T3pbEwY8W9aMMxF+VoCDY5wdEg7NOyu4kT7Vhlp67tqAD3lHjUrI5T5XCvs/6FYFnhHjLEpnYL3gqyQWWWKLPqUZn2MG7c1mMW8JMExOf4nDgx0dcYGQgAeGpza0WtOOofx3+zQGZ2YT7DA65GUgqv1mcCgYEAvo5LqjkAUyMzCpcDUIJDVYFPqrQi34nlk9MCw/NzeDm/f32xFvS/zHddrupe0FMOxU89EWZBQg4oVQ/xOLPe18HNoS96q7hEabaJGjji7Kf50nAa5Jn8u7DSZl8jMDOxRrzrhqLGgRuOdpDCZv6BhuwsuVUFvPSMm1Ym6yrF3j8=-----END RSA PRIVATE KEY-----"
GITHUB_APP_PRIVATE_KEY=${}
helm install arc-runner-set \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_app_id="${GITHUB_APP_ID}" \
    --set githubConfigSecret.github_app_installation_id="${GITHUB_APP_INSTALLATION_ID}" \
    --set githubConfigSecret.github_app_private_key="${GITHUB_APP_PRIVATE_KEY}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/auto-scaling-runner-set --version 0.1.0