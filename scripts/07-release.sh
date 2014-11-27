#!/bin/bash

# The next three lines are for the go shell.
export SCRIPT_NAME="release"
export SCRIPT_HELP="Create a release."
[[ "$GOGO_GOSH_SOURCE" -eq 1 ]] && return 0

# Normal script execution starts here.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"/../
source "$DIR"/env.sh || exit 1
cd "$DIR" || exit 1

assert_env GH_KEY || exit 1
prompt_env GL_VERSION "Version (e.g., 0.1): "
export GITHUB_TOKEN=$GH_KEY
git tag v$GL_VERSION || exit 1

github-release release \
    --user formwork-io \
    --repo greenline \
    --tag v$GL_VERSION \
    --name "$GL_VERSION" \
    --description "Greenline v$GL_VERSION binaries for Linux and OS X"

