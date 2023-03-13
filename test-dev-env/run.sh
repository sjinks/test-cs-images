#!/bin/sh

build_date="$(date +%s)"
id_label="dev-env-container=${build_date}"

devcontainer up --workspace-folder "$(dirname "$0")" --remove-existing-container --id-label "${id_label}" --mount-workspace-git-root false < /dev/null
docker exec -it "$(docker ps -aq --filter label="${id_label}")" /bin/bash
docker rm -f "$(docker ps -aq --filter label="${id_label}")"
