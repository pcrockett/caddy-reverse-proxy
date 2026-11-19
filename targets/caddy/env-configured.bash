#!/usr/bin/env blarg

depends_on user-created

CADDY_USER=caddy
FILE_NAME=proxy.env
REPO_CONFIG_DIR="${REPO_CONFIG_DIR}/caddy"
ENV_FILE="/etc/caddy/${FILE_NAME}"
WITH_UMASK="${BLARG_MODULE_DIR}/bin/with-umask"

satisfied_if() {
  checkpoint_is_current "${REPO_CONFIG_DIR}/${FILE_NAME}.template" \
    && test -s "${ENV_FILE}" \
    && test "$(stat --format '%U:%G %a' "${ENV_FILE}")" = "root:${CADDY_USER} 640"
}

apply() {
  PORKBUN_API_KEY="${PORKBUN_API_KEY:?set in .envrc}" \
    PORKBUN_API_SECRET_KEY="${PORKBUN_API_SECRET_KEY:?set in .envrc}" \
    INTERNAL_APEX_DOMAIN="${INTERNAL_APEX_DOMAIN:?set in .envrc}" \
    template_render "${REPO_CONFIG_DIR}/${FILE_NAME}.template"

  mkdir --parent "$(dirname "${ENV_FILE}")"
  cat "${REPO_CONFIG_DIR}/${FILE_NAME}" \
    | as_root "${WITH_UMASK}" u=rw,g=r,o= dd of="${ENV_FILE}" status=none
  as_root chown "root:${CADDY_USER}" "${ENV_FILE}"
  test -s "${ENV_FILE}"

  # remove the generated file, just to reduce the amount of secrets lying around
  rm "${REPO_CONFIG_DIR}/${FILE_NAME}"

  checkpoint_success
}
