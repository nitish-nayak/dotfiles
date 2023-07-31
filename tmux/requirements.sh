#!/bin/bash

function install_tmuxutils {

    if [ ! -d "$HOME/.tmux" ]; then
        echo "Installing TPM"
        git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
        "$HOME"/.tmux/plugins/tpm/scripts/install_plugins.sh

        echo "Configuring my tmux powerline"
        TMUX_POWERLINE_PATH="$HOME"/.tmux/plugins/tmux-powerline/
        cp -r tmux-powerline-theme.sh "$TMUX_POWERLINE_PATH"/themes/.
        for seg in ./tmux-powerline-segments/*; do
          cp -r "$seg" "$TMUX_POWERLINE_PATH"/segments/.
        done

    fi

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
