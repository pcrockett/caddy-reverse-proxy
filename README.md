# caddy reverse proxy configuration

My internal homelab reverse proxy configuration. It does TLS termination, acquires
certificates via Porkbun's API using ACME DNS challenges. While this would be usable
exposed to the Internet, I advise against it. This repo assumes you're accessing it via
Tailscale.

It runs Arch, btw.

## How this works

I'm using my own target-based Bash configuration management tool
[blarg](https://github.com/pcrockett/blarg) to automate everything. All targets are in
the `targets` directory, with the entrypoint being
[`targets/main.bash`](./targets/main.bash). The `blarg` tool itself is
[included in this repository](./bin/blarg) so there's no need to install it beforehand.

<!--
  [file:bin/blarg]
  [file:targets/main.bash]
-->

Targets are organized in a dependency tree, making sure the right steps are taken in the
right order, and they are never re-run unless absolutely necessary. This means you can
execute all these targets however often you want, and only the necessary ones will
actually be applied.

## Getting started

Clone this repo to a local "controller" device (i.e. your laptop). You will apply the
configuration to a remote Archlinux device via SSH.

All tools can be installed on your local machine via [mise](https://mise.jdx.dev/), and
environment variables via [direnv](https://direnv.net/).

```bash
mise trust
mise install
cp .envrc.template .envrc
```

Edit `.envrc` appropriately, run `direnv allow`, then `just apply`.
