#!/usr/bin/env blarg

USERNAME=caddy

satisfied_if() {
  id "${USERNAME}"
}

apply() {
  as_root useradd --system \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    "${USERNAME}"
}
