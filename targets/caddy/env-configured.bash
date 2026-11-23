#!/usr/bin/env blarg

depends_on user-created

CADDY_USER=caddy
FILE_NAME=proxy.env
REPO_CONFIG_DIR="${REPO_CONFIG_DIR}/caddy"
LOCAL_ENV_FILE="${REPO_CONFIG_DIR}/${FILE_NAME}"
SYSTEM_ENV_FILE="/etc/caddy/${FILE_NAME}"

satisfied_if() {
  test -f "${SYSTEM_ENV_FILE}" \
    && checkpoint_is_current "${LOCAL_ENV_FILE}.template" "${BLARG_MODULE_DIR}/.envrc"
}

apply() {
  render_env
  as_root mkdir --parent "$(dirname "${SYSTEM_ENV_FILE}")"
  as_root install \
    --mode=u=rw,g=r,o= \
    --owner=root \
    --group="${CADDY_USER}" \
    "${LOCAL_ENV_FILE}" \
    "${SYSTEM_ENV_FILE}"
  test -s "${SYSTEM_ENV_FILE}"

  # remove the generated file, just to reduce the amount of secrets lying around
  rm -f "${LOCAL_ENV_FILE}"

  if [ "$(systemctl is-active caddy.service)" = "active" ]; then
    as_root systemctl restart caddy.service
  fi

  checkpoint_success
}

render_env() {
  PORKBUN_API_KEY="${PORKBUN_API_KEY:?set in .envrc}" \
    PORKBUN_API_SECRET_KEY="${PORKBUN_API_SECRET_KEY:?set in .envrc}" \
    INTERNAL_APEX_DOMAIN="${INTERNAL_APEX_DOMAIN:?set in .envrc}" \
    template_render "${REPO_CONFIG_DIR}/${FILE_NAME}.template"
}
