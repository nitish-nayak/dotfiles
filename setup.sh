#!/bin/bash

## requires :
# zsh
# git
# tmux
# vim
# curl
# python
# neovim

function init_macos {

    # get homebrew first
    if command -v brew &> /dev/null
    then
        echo "Updating Homebrew"
        brew update
    else
        echo "Installing Homebrew"
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # install some utilities
    brew install coreutils
    brew install htop

    # install python
    echo "Installing python"
    brew install pyenv
    brew install zlib

    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init --path)"
    pyenv install 3.10.4
    pyenv global 3.10.4

    pip install --upgrade pip
    pip install ipython

    # install vim
    echo "Installing vim"
    brew install vim

    # install neovim
    echo "Installing neovim"
    brew install neovim

    # install tmux
    echo "Installing tmux"
    brew install tmux

}

# Make box around text @climagic
function box() { t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }

dir=`pwd`
olddir="$HOME/".backup
config_folders="shell vim tmux nvim"

echo "Creating backup folder"
if [ ! -d "$olddir" ]; then
    mkdir -p "$olddir"
fi

if [ $(uname) == "Darwin" ]; then
    echo "Configuring requirements for OS X"
    init_macos
fi

echo "Setting up my config for : "
for co in $config_folders; do
    box "$co"
    cd $co
    if [ -f "pyrequirements.txt" ]; then
        echo "Installing python requirements for $co first"
        pip install --user -r pyrequirements.txt
    fi
    source install.sh
    cd $dir
done
