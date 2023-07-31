#!/bin/bash

## requires :
# zsh
# git
# tmux
# vim
# curl
# python for neovim (with modules defined in nvim/requirements.txt)


# Make box around text @climagic
function box() { t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }

dir=`pwd`
olddir="$HOME/".backup
config_folders="shell vim tmux nvim"

echo "Creating backup folder"
if [ ! -d "$olddir" ]; then
    mkdir -p "$olddir"
fi

echo "Setting up my config for : "
for co in $config_folders; do
    box "$co"
    cd $co
    source requirements.sh
    cd $dir
done
