#!/bin/bash

function install_node {

    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # run this first
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # now install node
    nvm install node
    nvm use node

}

function install_linux {

    # rg, fd, bat
    if [ ! -d ~/.local/bin ]; then
        mkdir -p ~/.local/bin
    fi
    cpexe=~/.local/bin

    mkdir tmp
    cd tmp

    # install neovim
    echo "Installing neovim"
    wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
    tar zvxf nvim-linux64.tar.gz

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

    cp nvim-linux64/bin/nvim "$cpexe"/.
    cp bat-v0.23.0-x86_64-unknown-linux-musl/bat "$cpexe"/.
    cp fd-v8.7.0-x86_64-unknown-linux-musl/fd "$cpexe"/.
    cp ripgrep-13.0.0-x86_64-unknown-linux-musl/rg "$cpexe"/.
    cp shellcheck-stable/shellcheck "$cpexe"/.

    cd ../
    rm -r tmp

    echo "Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --no-bash --completion --key-bindings --no-update-rc

    echo "Installing node"
    install_node

}

function install_pre {

    echo "Installing fzf bat fd rg shellcheck"
    brew install fzf bat fd rg shellcheck
    "$(brew --prefix)/opt/fzf/install" --no-bash --completion --key-bindings --no-update-rc

    echo "Installing node"
    install_node
}

function setup_neovim {

    # Link neovim config
    if [ ! -d ~/.config/nvim ];then
        mkdir -p ~/.config/nvim/lua
    else
        echo "Creating backup"
        mv ~/.config/nvim ~/.backup/.
        mkdir -p ~/.config/nvim/lua
    fi

    echo "Installing vim-plug"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Configuring neovim"
    ln -s `pwd`/init.vim ~/.config/nvim/init.vim
    for i in `pwd`/lua/*; do
        ln -s "$i" ~/.config/nvim/lua/`basename "$i"`
    done

    echo "installing neovim dependencies"
    if [ "$(uname)" == "Darwin" ]; then
        install_pre
    elif [[ "$(uname)" == "Linux" || -n `uname -a | grep 'Ubuntu'` ]]; then
        install_linux
    else
        exit 1
    fi
    if command -v nvim &> /dev/null; then
        echo "installing neovim plugins"
        nvim +PlugInstall +qall
    fi

}

setup_neovim
