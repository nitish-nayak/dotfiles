#!/bin/bash

function install_vimutils {

    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        echo "Installing Vundle"
        # install Vundle for vimrc
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        echo "Getting my colorscheme"
        wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
        mkdir -p "$HOME"/.vim/colors/
        mv badwolf.vim "$HOME"/.vim/colors
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
    if command -v vim &> /dev/null; then
        echo "Installing vim plugins"
        vim +PluginInstall +qall
    fi

}

setup_vim
