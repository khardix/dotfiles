#!/usr/bin/env bash

# Exit after failed command
set -e

script_dir=$(dirname "${BASH_SOURCE[0]}")

# Minimal required environment
cd "$script_dir"
git pull --ff-only  # ensure latest published state
git submodule update --init --recursive -- _tools  # Ensure tools are available

# Run dotbot for all provided configuration files
dotbot=_tools/dotbot/bin/dotbot

# BFS search for config files
find . -type f -name 'dotbot.conf.yaml' -printf '%d\t%P\n' \
    | sort -nk1 \
    | cut -f2- \
    | while read -r config
do
    echo "[$config]"
    ${dotbot} -d "$(dirname "$config")" -c "$config" --verbose
done
