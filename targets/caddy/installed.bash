#!/usr/bin/env blarg

LOCAL_BIN="${BLARG_MODULE_DIR}/artifact/caddy"
SYSTEM_BIN="/usr/local/bin/caddy"

satisfied_if() {
  test -x "${SYSTEM_BIN}" \
    && test -x "${LOCAL_BIN}" \
    && test "$("${LOCAL_BIN}" --version)" = "$("${SYSTEM_BIN}" --version)"
}

apply() {
  if [ -x "${LOCAL_BIN}" ]; then
    as_root install --mode=u=rw,g=rw,o=rx "${LOCAL_BIN}" "${SYSTEM_BIN}"
  else
    panic "Run \`just build-caddy\` to generate the caddy executable and then apply."
  fi
}
