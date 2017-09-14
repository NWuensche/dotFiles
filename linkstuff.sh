#!/bin/sh
cd;
mkdir -p .config/terminator
ln -f .dotFiles/configs/config.terminator .config/terminator/config
ln -f .dotFiles/gitStuff/.gitconfig .gitconfig

mkdir -p .i3
ln -f .dotFiles/i3Stuff/config .i3/config
ln -f .dotFiles/i3Stuff/config .i3/config

mkdir -p bin
ln -f .dotFiles/scripts/extract bin/extract

ln -f .dotFiles/terminalStuff/.bashrc .bashrc
ln -f .dotFiles/terminalStuff/.bash_profile .bash_profile
ln -f .dotFiles/terminalStuff/.zprofile .zprofile
ln -f .dotFiles/terminalStuff/.zshrc .zshrc

mkdir -p .vim/plugins
ln -f .dotFiles/vimStuff/.vimrc .vimrc
ln -f .dotFiles/vimStuff/autoswap.vim .vim/plugins/autoswap.vim

ln -f .dotFiles/.xinitrc .xinitrc
