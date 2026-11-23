#!/usr/bin/env blarg

LOCAL_BIN="${BLARG_MODULE_DIR}/artifact/caddy"
SYSTEM_BIN="/usr/local/bin/caddy"

satisfied_if() {
  local_version="$("${LOCAL_BIN}" --version)"
  installed_version="$("${SYSTEM_BIN}" --version)"
  test "${local_version}" = "${installed_version}"
}

apply() {
  as_root install --mode=u=rw,g=rx,o=rx "${LOCAL_BIN}" "${SYSTEM_BIN}"
}
