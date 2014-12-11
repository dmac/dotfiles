#!/bin/sh

set -e
sudo apt-get install git gcc make pkg-config libx11-dev libxtst-dev libxi-dev
cd $DOTFILES/vendor/xcape
make
mkdir -p ~/bin
ln -fs $DOTFILES/vendor/xcape/xcape ~/bin/xcape
xcape -e 'Control_L=Escape'
