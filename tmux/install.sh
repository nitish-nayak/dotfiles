#!/bin/bash

function install_tmuxutils {

    if [ ! -d ~/.tmux ]; then
        echo "Installing TPM"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins
        # start a server but don't attach to it
        tmux start-server
        # create a new session but don't attach to it either
        tmux new-session -d
        sleep 1
        # install the plugins
        ~/.tmux/plugins/tpm/scripts/install_plugins.sh
        # killing the server is not required, I guess
        tmux kill-server
    fi

    echo "Configuring my tmux powerline"
    TMUX_POWERLINE_PATH=~/.tmux/plugins/tmux-powerline/
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

    if [ -f ~/.tmux.conf ]; then
        echo "Creating backup"
        mv ~/.tmux.conf ~/.backup/tmux.conf
    fi

    echo "Linking my tmux.conf"
    ln -s `pwd`/tmux.conf ~/.tmux.conf

    install_tmuxutils
    echo "Linking tmux powerline"
    ln -s `pwd`/powerline/tmux-powerlinerc ~/.tmux-powerlinerc

}

setup_tmux
