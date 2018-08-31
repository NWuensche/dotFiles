#!/bin/bash

set -e #Exit after first non zero error code

if [ ! -d /run/media/nwuensche/TOSHIBA\ EXT ]
then
    echo "Mount external drive"
    exit 1
fi

mkdir -p ~/Bilder
mkdir -p ~/Dokumente
mkdir -p ~/Downloads

#/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/AufPC/* ~/ -r
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/Bilder/Wallpaper.jpg ~/Bilder/
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/Master_Berlin ~/Dokumente/ -r
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/tud-cacert.pem ~/Dokumente/
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/saveFolder ~ -r

sudo pacman -Syu
#sudo pacman -S xorg xf86-video-intel lightdm lightdm-gtk-greeter i3-wm dmenu i3status--noconfirm
#sudo sh -c 'echo "greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf'
#sudo systemctl enable lightdm.service
#TODO phantomjs
# Remove vim to install gvim for better clipboard support
#sudo pacman -R vim --noconfirm
#sudo pacman -S jdk10-openjdk  tmux pwgen xclip gvim python3 maven redshift steam calibre htop git vlc curl wget vifm zsh terminator gparted ffmpeg gimp xss-lock xautolock virtualbox youtube-dl trash-cli scrot udiskie ntfs-3g feh chromium texlive-most biber android-file-transfer wine unrar mps-youtube weechat arandr pdfgrep kdenlive vim-spell-de vim-spell-en cronie calcurse --noconfirm
#trizen (Better yaourt)
#git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si  --noconfirm

#trizen -S imapfilter --noconfirm
#TU Latex Stuff
#sudo tlmgr install opensans
#sudo tlmgr install tudsc
#updmap -sys

#VSCode
#wget https://go.microsoft.com/fwlink/\?LinkID\=760868 -o code.deb
#sudo dpkg -i code.deb
#sudo apt install -f
#rm code.deb

#Vim German Spell Check
#sudo vim +'set spell spelllang=en,de' +y +1 +q +q

#Qute Browser
#wget https://github.com/qutebrowser/qutebrowser/releases/download/v1.1.1/qutebrowser_1.1.1-1_all.deb
#wget https://qutebrowser.org/python3-pypeg2_2.15.2-1_all.deb
#sudo apt install ./python3-pypeg2_*_all.deb ./qutebrowser_*_all.deb
#pip3 install readability-lxml
#rm *.deb

#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#git clone https://github.com/haikarainen/light.git
#cd light
#sh autogen.sh
#./configure
#sudo make
#sudo make install
#cd ..
#trash light

#mv ~/dotFiles ~/.dotFiles
#Savefolder Files
#cp ~/saveFolder/ssh ~/.ssh -r # Must do this before spark, because config will be overwritten otherwise
#/bin/cp -r ~/saveFolder/.jarsNotToSave ~
#cp -r ~/saveFolder/ssh ~/.ssh
#crontab ~/saveFolder/listCrontab;
#sudo /bin/cp  ~/saveFolder/hosts /etc/hosts;
#sudo /bin/cp -r  ~/saveFolder/system-connections /etc/NetworkManager

#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
#chsh -s `which zsh` #TODO Funktioniert nicht
#Just for super-user-spark
#curl https://nixos.org/nix/install | sh
#. /home/nwuensche/.nix-profile/etc/profile.d/nix.sh
#nix-env --install super-user-spark
# For fzf in Vim
#nix-env --install fd
~/.nix-profile/bin/spark -r deploy ~/.dotFiles/dotFiles.sus
~/.nix-profile/bin/spark -r deploy ~/saveFolder/saveFolder.sus
#vim +PluginInstall +q +q
#vim +PlugInstall +q +q
#For YouCompleteMe
#sudo apt-get install build-essential cmake
#cd ~/.vim/bundle/YouCompleteMe
#./install.py --clang-completer

#Hard Link for every Script to be part of dmenu
for fullfile in ~/.dotFiles/scripts/*; do
        filename=$(basename -- "$fullfile")
        ln -f $fullfile "/home/nwuensche/bin/$filename"
done
for fullfile in ~/saveFolder/privateScripts/*; do
        filename=$(basename -- "$fullfile")
        ln -f $fullfile "/home/nwuensche/bin/$filename"
done


git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

gpg --import ~/saveFolder/gpg_key.asc

/bin/cp ~/.dotFiles/terminalStuff/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

#Android Studio
#wget https://dl.google.com/dl/android/studio/ide-zips/3.0.1.0/android-studio-ide-171.4443003-linux.zip as.zip
#Depencies
#sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 -y
#sudo unzip as.zip -d /opt/
#sudo chmod -R 0777 /opt/android-studio
#/bin/rm as.zip
#/opt/android-studio/bin/studio.sh
#ln -s ~/android-studio/bin/studio.sh ~/bin/a

git clone https://github.com/NWuensche/android-app ~/wallabag

clear
echo "Install Tmux Plugins with Prefix + I"
echo "Add VPN"
echo "Import Android Studio Settings"
echo "Add Printer, set default paper size to A4"
echo "Change DNS Server"
echo "Fix SSH"
echo "Fix Touchpad"
echo "Use Techniktipps"
