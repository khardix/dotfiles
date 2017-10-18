#!/usr/bin/env bash

# Exit after failed command
set -e

script_dir=$(dirname "${BASH_SOURCE[0]}")

# Minimal required environment
cd "$script_dir"
git pull --ff-only  # ensure latest published state
git submodule update --init --recursive -- _tools  # Ensure tools are available

# Run dotbot for all provided configuration files
function dotbot
{
    local -r bin=_tools/dotbot/bin/dotbot
    local -r config=${1:-dotbot.conf.yaml}

    echo
    echo "[$config]"
    ${bin} -d "$(dirname "$config")" -c "$config" --verbose
}

# Process main configuration first
dotbot

# BFS search for additional configuration files
find . -mindepth 2 -type f -name 'dotbot.conf.yaml' -printf '%d\t%P\n' \
    | sort -nk1 \
    | cut -f2- \
    | while read -r config
do
    dotbot "${config}"
done
