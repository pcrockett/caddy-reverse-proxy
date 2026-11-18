# caddy reverse proxy configuration

## How this works

I'm using my own target-based Bash configuration management tool
[blarg](https://github.com/pcrockett/blarg) to automate everything. All targets are in
the `targets` directory, with the entrypoint being
[`targets/main.bash`](./targets/main.bash). The `blarg` tool itself is
[included in this repository](./bin/blarg) so there's no need to install anything
beforehand.

<!--
  [file:bin/blarg]
  [file:targets/main.bash]
-->

Targets are organized in a dependency tree, making sure the right steps are taken in the
right order, and they are never re-run unless absolutely necessary. This means you can
execute all these targets however often you want, and only the necessary ones will
actually be applied.
