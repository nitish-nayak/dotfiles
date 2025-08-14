#!/bin/bash

function install_zshutils {

    if [ ! -d ~/.oh-my-zsh ]; then

        # install oh-my-zsh
        echo "Installing Oh-My-ZSH"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --skip-chsh --keep-zshrc

        ## install oh-my-zsh plugins
        echo "Installing some of my favorite oh-my-zsh plugins.."
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/laurenkt/zsh-vimto ~/.oh-my-zsh/custom/plugins/zsh-vimto
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi

    ## install zsh theme
    if [ ! -d ~/.zsh ]; then
        mkdir -p ~/.zsh
    fi
    git clone https://github.com/intelfx/pure.git ~/.zsh/pure

    ln -s ~/.zsh/pure/pure.zsh ~/.zsh/pure/prompt_pure_setup
    ln -s ~/.zsh/pure/async.zsh ~/.zsh/pure/async

    # install other cool stuff
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
}

function setup_shell {

    echo "Setting up my shell configs"
    ln -s `pwd`/custom/utils ~/.utils
    ln -s `pwd`/custom/aliases ~/.aliases

    echo "Setting up shell rc"
    ln -s `pwd`/zshrc ~/.myzshrc.sh
    ln -s `pwd`/bashrc ~/.mybashrc.sh

    if ! [ -f ~/.zshrc ]; then
        echo "Creating zshrc"
        touch ~/.zshrc
    fi
    if ! [ -f ~/.bashrc ]; then
        echo "Creating bashrc"
        touch ~/.bashrc
    fi
    echo "source ~/.myzshrc.sh" >> ~/.zshrc
    echo "source ~/.mybashrc.sh" >> ~/.bashrc

    install_zshutils
    echo "Setting up alt zsh theme"
    ln -s `pwd`/custom/nitish_rr.zsh-theme ~/.oh-my-zsh/themes/nitish_rr.zsh-theme

    echo "Sourcing"
    source ~/.bashrc

}

setup_shell
