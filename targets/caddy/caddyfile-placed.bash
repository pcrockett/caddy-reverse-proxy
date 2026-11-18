#!/usr/bin/env blarg

FILE=/etc/caddy/Caddyfile

satisfied_if() {
  files_are_same "${REPO_CONFIG_DIR}/caddy/Caddyfile" "${FILE}"
}

apply() {
  as_root mkdir --parent "$(dirname "${FILE}")"
  as_root cp "${REPO_CONFIG_DIR}/caddy/Caddyfile" "${FILE}"
}
