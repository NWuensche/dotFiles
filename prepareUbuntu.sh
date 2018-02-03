#!/bin/sh

echo "First install Android-Studio!"
echo "Also Add saveFolder"
sudo apt update
sudo apt upgrade
sudo apt install default-jdk chromium-browser pwgen xclip vim python3 maven redshift steam calibre htop i3 git vlc curl vifm zsh terminator gparted ffmpeg gimp xss-lock xautolock phantomjs virtualbox youtube-dl trash-cli scrot udiskie feh texlive-full mtp-tools mtpfs gmtp curl wine-stable unrar arp-scan podget
sudo apt autoremove firefox totem rhythmbox

git clone https://github.com/haikarainen/light.git
cd light
sudo make
sudo make install
cd ..
trash light

mv ~/dotfiles ~/.dotFiles

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`
#Just for super-user-spark
curl https://nixos.org/nix/install | sh
. /home/nwuensche/.nix-profile/etc/profile.d/nix.sh
nix-env --install super-user-spark
~/.nix-profile/bin/spark -r deploy ~/.dotFiles/dotFiles.sus
~/.nix-profile/bin/spark -r deploy ~/saveFolder/saveFolder.sus

cp ~/saveFolder/.thunderbird ~ -r

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

ln -s ~/android-studio/bin/studio.sh ~/bin/


/bin/cp ~/.dotFiles/terminalStuff/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme 


