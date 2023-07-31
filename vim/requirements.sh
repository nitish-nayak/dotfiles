#!/bin/bash

function install_vimutils {

    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        echo "Installing Vundle"
        # install Vundle for vimrc
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}

function setup_vim {

    if [ -f "$HOME/.vimrc" ]; then
        echo "Creating backup"
        mv "$HOME/.vimrc" "$HOME/.backup/vimrc"
    fi

    echo "Linking my vimrc"
    ln -s `pwd`/vimrc "$HOME"/.vimrc

    install_vimutils
    echo "Installing vim plugins"
    vim +PluginInstall +qall

}

setup_vim
