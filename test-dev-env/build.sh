#!/bin/sh

devcontainer build --workspace-folder "$(dirname "$0")" --image-name test-dev-env < /dev/null
