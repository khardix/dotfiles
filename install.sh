#!/usr/bin/env bash

set -e
git clone --recursive https://github.com/khardix/dotfiles.git
cd dotfiles && git remote 'set-url' --push origin git@github.com:khardix/dotfiles.git

exec ./setup.sh
