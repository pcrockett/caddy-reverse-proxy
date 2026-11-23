[private]
_default:
    @just --list

# Run lint script, including pre-commit
lint:
    ./bin/lint.sh

# Apply config to remote machine
apply *args:
    ./bin/blarg --ssh "${SSH_DEST}" --verbose {{args}} ./targets/main.bash

# Update blarg from upstream
update-blarg:
    @curl --proto '=https' --tlsv1.3 \
        --silent \
        --show-error \
        --fail \
        --location "https://github.com/pcrockett/blarg/raw/refs/heads/main/blarg" \
        >bin/blarg.tmp
    @chmod +x bin/blarg.tmp
    @mv bin/blarg.tmp bin/blarg

# Update this repo from its copier template
update-template:
    copier update --skip-answered

# Build customer version of Caddy with Porkbun extension
build-caddy:
    mkdir -p artifact
    # porkbun extension v0.3.1
    xcaddy build \
        --with github.com/caddy-dns/porkbun@ce0d8d12ed133b8438c28863f6bf3c63bf83a279 \
        --output artifact/caddy
