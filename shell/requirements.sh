#!/bin/bash

function install_zshutils {

    if [ ! -d "$HOME/.oh-my-zsh" ]; then

        # install oh-my-zsh
        echo "Installing Oh-My-ZSH"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        ## install oh-my-zsh plugins
        echo "Installing some of my favorite oh-my-zsh plugins.."
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
        git clone https://github.com/laurenkt/zsh-vimto "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-vimto
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
    fi
}

function setup_shell {

    echo "Setting up my shell configs"
    ln -s `pwd`/custom/utils ~/.utils
    ln -s `pwd`/custom/aliases ~/.aliases

    echo "Setting up shell rc"
    ln -s `pwd`/zshrc "$HOME"/.myzshrc
    ln -s `pwd`/bashrc "$HOME"/.mybashrc

    if ! [ -f "$HOME/.zshrc" ]; then
        echo "Creating zshrc"
        touch "$HOME/.zshrc"
    fi
    if ! [ -f "$HOME/.bashrc" ]; then
        echo "Creating bashrc"
        touch "$HOME/.bashrc"
    fi
    echo "source $HOME/.myzshrc" >> "$HOME/.zshrc"
    echo "source $HOME/.mybashrc" >> "$HOME/.bashrc"

    install_zshutils
    echo "Setting up zsh theme"
    ln -s `pwd`/custom/nitish_rr.zsh-theme "$HOME"/.oh-my-zsh/themes/nitish_rr.zsh-theme

}

setup_shell
