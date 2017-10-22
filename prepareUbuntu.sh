#!/bin/sh

echo "First install Android-Studio!"
echo "Also Add saveFolder"
sudo apt update
sudo apt upgrade
sudo apt install default-jdk android-studio chromium-browser pwgen xclip vim python3 maven redshift steam calibre htop i3 git vlc curl vifm zsh terminator gparted ffmpeg gimp xss-lock xautolock phantomjs virtualbox youtube-dl trash-cli scrot udiskie xbacklight feh
sudo apt autoremove firefox

mv dotFiles .dotFiles

#Just for super-user-spark
curl https://nixos.org/nix/install | sh
. /home/nwuensche/.nix-profile/etc/profile.d/nix.sh
nix-env --install super-user-spark
~/.nix-profile/bin/spark -r deploy ~/.dotFiles/dotFiles.sus
~/.nix-profile/bin/spark -r deploy ~/saveFolder/saveFolder.sus

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

ln -s ~/android-studio/bin/studio.sh ~/bin/

/bin/mv ~/.dotFiles/terminalStuff/agnoster.zsh-theme .oh-my-zsh/themes/agnoster.zsh-theme 


