#!/usr/bin/env bash

# Exit after failed command
set -e

# Dotbot configuration
CONFIG="dotbot.conf.yaml"
DOTBOT_MODULE="dotbot"
DOTBOT_BIN="bin/dotbot"

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run dotbot
cd "$BASEDIR"
git submodule update --init --recursive "$DOTBOT_MODULE"
"$BASEDIR/$DOTBOT_MODULE/$DOTBOT_BIN" -v -d "$BASEDIR" -c "$CONFIG" "${@}"
