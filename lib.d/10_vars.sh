# shellcheck shell=bash

export PATH="${BLARG_MODULE_DIR}/bin:${PATH}"
STATE_DIR="${HOME}/.local/state/$(basename "${BLARG_MODULE_DIR}")"
export STATE_DIR
export REPO_CONFIG_DIR="${BLARG_MODULE_DIR}/config"
export REPO_BIN_DIR="${BLARG_MODULE_DIR}/bin"
