# shellcheck shell=bash

export PATH="${BLARG_MODULE_DIR}/bin:${PATH}"
STATE_DIR="${HOME}/.local/state/$(basename "${BLARG_MODULE_DIR}")"
export STATE_DIR
export REPO_CONFIG_DIR="${BLARG_MODULE_DIR}/config"
export REPO_BIN_DIR="${BLARG_MODULE_DIR}/bin"

if [ "${ENVRC_LOADED:-}" == "" ]; then
  strict_env() { :; }
  PATH_add() { :; }
  source "${BLARG_MODULE_DIR}/.envrc"
fi
