#!/usr/bin/env blarg

depends_on user-created bitwarden/cli-installed core/jq-installed

CADDY_USER=caddy
FILE_NAME=proxy.env
REPO_CONFIG_DIR="${REPO_CONFIG_DIR}/caddy"
ENV_FILE="/etc/caddy/${FILE_NAME}"

satisfied_if() {
  checkpoint_is_current "${REPO_CONFIG_DIR}/${FILE_NAME}.template" \
    && test -s "${ENV_FILE}" \
    && test "$(stat --format '%U:%G %a' "${ENV_FILE}")" = "root:${CADDY_USER} 640"
}

apply() {
  satisfy bitwarden/synced
  bw_load_item machine.proxy

  PORKBUN_API_KEY="$(bw_value porkbun.api-key)" \
  PORKBUN_API_SECRET_KEY="$(bw_value porkbun.api-secret-key)" \
  INTERNAL_APEX_DOMAIN="${INTERNAL_APEX_DOMAIN:?set INTERNAL_APEX_DOMAIN in .envrc}" \
    template_render "${REPO_CONFIG_DIR}/${FILE_NAME}.template"

  mkdir --parent "$(dirname "${ENV_FILE}")"
  cat "${REPO_CONFIG_DIR}/${FILE_NAME}" | tee "${ENV_FILE}"
  chown "root:${CADDY_USER}" "${ENV_FILE}"
  chmod 0640 "${ENV_FILE}"
  test -s "${ENV_FILE}"

  # remove the generated file, just to reduce the amount of secrets lying around
  rm "${REPO_CONFIG_DIR}/${FILE_NAME}"

  checkpoint_success
}
