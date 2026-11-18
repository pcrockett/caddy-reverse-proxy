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
