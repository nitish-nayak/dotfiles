#!/bin/bash

function install_tmuxutils {

    if [ ! -d "$HOME/.tmux" ]; then
        echo "Installing TPM"
        git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
        "$HOME"/.tmux/plugins/tpm/scripts/install_plugins.sh
    fi

    echo "Configuring my tmux powerline"
    TMUX_POWERLINE_PATH="$HOME"/.tmux/plugins/tmux-powerline/
    dest="$TMUX_POWERLINE_PATH"themes/tmux-powerline-theme.sh
    if [ ! -f "$dest" ]; then
        ln -s `pwd`/powerline/tmux-powerline-theme.sh "$dest"
    fi

    for seg in `pwd`/powerline/tmux-powerline-segments/*; do
        dest="$TMUX_POWERLINE_PATH"segments/`basename "$seg"`
        if [ ! -f "$dest" ]; then
            ln -s "$seg" "$dest"
        fi
    done

}

function setup_tmux {

    if [ -f "$HOME/.tmux.conf" ]; then
        echo "Creating backup"
        mv "$HOME/.tmux.conf" "$HOME/.backup/tmux.conf"
    fi

    echo "Linking my tmux.conf"
    ln -s `pwd`/tmux.conf "$HOME"/.tmux.conf

    install_tmuxutils
    echo "Linking tmux powerline"
    ln -s `pwd`/powerline/tmux-powerlinerc "$HOME"/.tmux-powerlinerc

}

setup_tmux
