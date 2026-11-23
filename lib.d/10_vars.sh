# shellcheck shell=bash

export PATH="${BLARG_MODULE_DIR}/bin:${PATH}"
STATE_DIR="${HOME}/.local/state/proxy-vm-config"
export STATE_DIR
export REPO_CONFIG_DIR="${BLARG_MODULE_DIR}/config"
export REPO_BIN_DIR="${BLARG_MODULE_DIR}/bin"

if [ "${ENVRC_LOADED:-}" == "" ]; then
  strict_env() { :; }
  PATH_add() { :; }
  # shellcheck source=.envrc
  source "${BLARG_MODULE_DIR}/.envrc"
fi
