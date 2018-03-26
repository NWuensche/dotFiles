#!/bin/sh

echo "First install Android-Studio!"
echo "Also Add saveFolder"
sudo apt update
sudo apt upgrade -y
sudo apt install default-jdk pwgen xclip vim python3 maven redshift steam calibre htop i3 git vlc curl vifm zsh terminator gparted ffmpeg gimp xss-lock xautolock phantomjs virtualbox youtube-dl trash-cli scrot udiskie feh texlive-full mtp-tools mtpfs gmtp curl wine-stable unrar arp-scan podget silversearcher-ag jmtpfs googler mps-youtube urlview weechat arandr imapfilter -y
sudo apt install vim-gtk -y #For better clipboard
sudo apt autoremove firefox totem rhythmbox -y

#VSCode
wget https://go.microsoft.com/fwlink/\?LinkID\=760868 -o code.deb
sudo dpkg -i code.deb
sudo apt install -f
rm code.deb

#Vim German Spell Check
sudo apt-get install vim-scripts
sudo vim +'set spell spelllang=en,de' +y +1 +q +q

#Qute Browser
wget https://github.com/qutebrowser/qutebrowser/releases/download/v1.1.1/qutebrowser_1.1.1-1_all.deb
wget https://qutebrowser.org/python3-pypeg2_2.15.2-1_all.deb
sudo apt install ./python3-pypeg2_*_all.deb ./qutebrowser_*_all.deb
pip3 install readability-lxml
rm *.deb

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/haikarainen/light.git
cd light
sudo make
sudo make install
cd ..
trash light

mv ~/dotfiles ~/.dotFiles

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`
#Just for super-user-spark
curl https://nixos.org/nix/install | sh
. /home/nwuensche/.nix-profile/etc/profile.d/nix.sh
nix-env --install super-user-spark
# For fzf in Vim
nix-env --install fd
~/.nix-profile/bin/spark -r deploy ~/.dotFiles/dotFiles.sus
~/.nix-profile/bin/spark -r deploy ~/saveFolder/saveFolder.sus
vim +PluginInstall +q +q
vim +PlugInstall +q +q
#For YouCompleteMe
sudo apt-get install build-essential cmake
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

cp ~/saveFolder/.thunderbird ~ -r

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

ln -s ~/android-studio/bin/studio.sh ~/bin/

gpg --import ~/saveFolder/gpg_key.asc

/bin/cp ~/.dotFiles/terminalStuff/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

echo "Install Tmux Plugins with Prefix + I"

