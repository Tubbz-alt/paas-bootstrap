#!/bin/bash
set -eu

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

"${SCRIPT_DIR}/fly_sync_and_login.sh"

pipeline="self-terminate"
config="${SCRIPT_DIR}/../pipelines/concourse-lite-self-terminate.yml"

generate_vars_file() {
   cat <<EOF
---
deploy_env: ${DEPLOY_ENV}
log_level: ${LOG_LEVEL:-}
EOF
}

generate_vars_file > /dev/null # Check for missing vars

bash "${SCRIPT_DIR}/deploy-pipeline.sh" \
   "${pipeline}" "${config}" <(generate_vars_file)
