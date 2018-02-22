#!/bin/sh
set -eu

bosh_secrets_file=$1

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
bosh_password=$("${SCRIPT_DIR}"/val_from_yaml.rb secrets.bosh_admin_password "${bosh_secrets_file}")

bosh login --client="admin" --client-secret="${bosh_password}"
