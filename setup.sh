# vim: set filetype=zsh:

# Setup script for easy install of config files
# It assumes to be run in prepared empty directory for storing configs
# Requirements: git zsh vim

# First of all, clone self wit all submodules
git clone --recursive git@github.com:khardix/dotfiles.git .
git submodule foreach git checkout master

# Submodules should have their own setup scripts, run them
git submodule foreach "test -r setup.sh && $SHELL setup.sh || :"

# Setup remaining configs
function test_and_link
{
  test -h "$1" || ln -s $2 $1
}

# ### Tmux ###
test_and_link "$HOME/.tmux.conf" "$PWD/tmux/tmux.conf"
