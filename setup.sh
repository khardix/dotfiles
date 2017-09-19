#!/usr/bin/env bash

# Exit after failed command
set -e

# Minimal required environment - initialized tools submodules
script_dir=$(dirname "${BASH_SOURCE[0]}")
cd "$script_dir" && git submodule update --init --recursive -- _tools

# Run dotbot for all provided configuration files
dotbot=_tools/dotbot/bin/dotbot

# BFS search for config files
find . -type f -name 'dotbot.conf.yaml' -printf '%d\t%P\n' \
    | sort -nk1 \
    | cut -f2- \
    | while read -r config
do
    ${dotbot} -d "$(dirname "$config")" -c "$config" --verbose
done
