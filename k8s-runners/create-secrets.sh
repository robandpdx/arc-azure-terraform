#!/bin/bash

kubectl create secret generic ${ARC_ORG_1} \
    -n actions-runner-system \
    --from-literal=github_app_id=${ARC_ORG_1_APP_ID} \
    --from-literal=github_app_installation_id=${ARC_ORG_1_INSTALLATION_ID} \
    --from-file=github_app_private_key=${ARC_ORG_1_PRIVATE_KEY_FILE_PATH}

kubectl create secret generic ${ARC_ORG_2} \
    -n actions-runner-system \
    --from-literal=github_app_id=${ARC_ORG_2_APP_ID} \
    --from-literal=github_app_installation_id=${ARC_ORG_2_INSTALLATION_ID} \
    --from-file=github_app_private_key=${ARC_ORG_2_PRIVATE_KEY_FILE_PATH}

kubectl create secret generic ${ARC_ORG_3} \
    -n actions-runner-system \
    --from-literal=github_app_id=${ARC_ORG_3_APP_ID} \
    --from-literal=github_app_installation_id=${ARC_ORG_3_INSTALLATION_ID} \
    --from-file=github_app_private_key=${ARC_ORG_3_PRIVATE_KEY_FILE_PATH}

kubectl create secret generic ${ARC_ENTERPRISE_1} \
    -n actions-runner-system \
    --from-literal=github_token=${ARC_ENTERPRISE_1_PAT}