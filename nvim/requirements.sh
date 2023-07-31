#!/bin/bash

function install_linux {

    # rg, fd, bat
    if [ ! -d "$HOME"/.local/bin ]; then
        mkdir -p "$HOME"/.local/bin
    fi
    cpexe="$HOME"/.local/bin

    mkdir tmp
    cd tmp

    echo "Installing bat"
    curl -LO https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-musl.tar.gz
    tar zvxf bat-v0.23.0-x86_64-unknown-linux-musl.tar.gz

    echo "Installing fd"
    curl -LO https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-x86_64-unknown-linux-musl.tar.gz
    tar zvxf fd-v8.7.0-x86_64-unknown-linux-musl.tar.gz

    echo "Installing rg"
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
    tar zvxf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz

    echo "Installing shellcheck"
    curl -LO https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz
    tar xvf shellcheck-stable.linux.x86_64.tar.xz

    cp bat-v0.23.0-x86_64-unknown-linux-musl/bat "$cpexe"/.
    cp fd-v8.7.0-x86_64-unknown-linux-musl/fd "$cpexe"/.
    cp ripgrep-13.0.0-x86_64-unknown-linux-musl/rg "$cpexe"/.
    cp shellcheck-stable/shellcheck "$cpexe"/.

    cd ../
    rm -r tmp

    echo "Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --no-bash --completion --key-bindings --no-update-rc

    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # run this first
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # now install node
    nvm install node
    nvm use node

}

function setup_neovim {

    # Link neovim config
    if [ ! -d "$HOME/.config/nvim" ];then
        mkdir -p "$HOME/.config/nvim/lua"
    else
        echo "Creating backup"
        mv "$HOME/.config/nvim" "$HOME/.backup/."
    fi

    echo "Installing vim-plug"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Configuring neovim"
    ln -s `pwd`/init.vim "$HOME/.config/nvim/init.vim"
    for i in `pwd`/lua/*; do
        ln -s "$i" "$HOME/.config/nvim/lua/"`basename "$i"`
    done

    echo "installing neovim dependencies"
    install_linux
    echo "installing neovim plugins"
    nvim +PlugInstall +qall

}

setup_neovim
