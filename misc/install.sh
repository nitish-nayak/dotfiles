#!/bin/bash


function install_macos {

    echo "Installing chrome discord slack spotify go"
    brew install --cask google-chrome
    brew install --cask discord
    brew install --cask slack
    brew install --cask spotify
    brew install go
}

function setup_visp {

    if command -v go &> /dev/null; then
        if [ ! -d "$HOME/.config/visp" ]; then
            mkdir -p "$HOME/.config/visp"
        fi
        ln -s `pwd`/visp.conf "$HOME/.config/visp/visp.conf"

        echo "Installing visp for spotify"
        git clone https://github.com/ambientsound/visp ~/.visp
        prevdir=`pwd`
        cd ~/.visp
        make
        if [ ! -d "$HOME/.local/bin" ]; then
            mkdir -p "$HOME/.local/bin"
        fi
        ln -s `pwd`/bin/visp "$HOME/.local/bin/visp"
        cd $prevdir
    else
        echo "Need go to install visp!"
    fi

}

if [ "$(uname)" == "Darwin" ]; then
    install_macos
fi
setup_visp

echo "Upload vimium config on google chrome extension page if needed. Setup complete!"
