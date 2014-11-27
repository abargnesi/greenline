#!/bin/bash

# The next three lines are for the go shell.
export SCRIPT_NAME="upload"
export SCRIPT_HELP="Upload a $(uname) $(uname -m) archive to a release."
[[ "$GOGO_GOSH_SOURCE" -eq 1 ]] && return 0

# Normal script execution starts here.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"/../
source "$DIR"/env.sh || exit 1
cd "$DIR" || exit 1

if [ ! -x "$BUILD/greenline" ]; then
    echo "no build in $BUILD" >&2
    exit 1
fi

assert_env GH_KEY || exit 1
prompt_env GL_VERSION "Version (e.g., 0.1): "
export GITHUB_TOKEN=$GH_KEY

PLAT=$(uname | tr '[:upper:]' '[:lower:]')

github-release upload \
    --user formwork-io \
    --repo greenline \
    --tag v$GL_VERSION \
    --name "greenline-$PLAT-amd64" --file build/greenline

