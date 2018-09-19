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

/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/AufPC/* ~/ -r
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/Bilder/Wallpaper.jpg ~/Bilder/
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/Master_Berlin ~/Dokumente/ -r
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/tud-cacert.pem ~/Dokumente/
/bin/cp /run/media/nwuensche/TOSHIBA\ EXT/saveFolder ~ -r

sudo pacman -Syu --noconfirm

#trizen (Better yaourt)
git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si  --noconfirm

trizen -S xorg xf86-video-intel lightdm lightdm-gtk-greeter i3-wm dmenu i3status i3lock --noconfirm
sudo sh -c 'echo "greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf' #Configure Display (Login) Manager
sudo systemctl enable lightdm.service


# Remove vim to install gvim for better clipboard support
trizen -R vim --noconfirm
trizen -S jdk10-openjdk maven python3 git android-studio intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre `#Programming`\
    gvim vim-spell-de vim-spell-en `#Vim`\
    xdotool expect `# Automation Tools`\
    tmux terminator zsh `#Terminator Environment`\
    curl wget htop neomutt vifm feh mps-youtube pdfgrep calcurse w3m bc mplayer irssi `#Terminal Tools`\
    pwgen xclip ffmpeg xss-lock xautolock youtube-dl trash-cli scrot udiskie ntfs-3g unrar cronie lynx ttf-liberation openssh imapfilter urlview `#Terminal Support Tools`\
    tcsh cups `#Printer Tools`\
    xf86-input-synaptic xf86-input-mtrack `#Touchpad Tools`\
    ttf-liberation pango `#Fonts and Font Tools`\
    alsa-utils pulseaudio `#Audio`\
    steam calibre vlc gimp chromium kdenlive libreoffice-fresh-de  evince `#X Tools`\
    redshift gparted  arandr wine android-file-transfer notification-daemon `# X Support Tools`\
    virtualbox virtualbox-host-modules-arch virtualbox-guest-iso `#Virtualbox`\
    texlive-most biber texlive-localmanager-git `#Latex`\
    --noconfirm 

#User is allowed to change audio
sudo usermod -aG audio nwuensche
#TU Latex Stuff
#tllocalmgr install tudscr
#tllocalmgr install opensans
#echo Y | tllocalmgr update chngcntr
#sudo texhash

#Fix Touch to Click Touchpad
cat /etc/X11/xorg.conf.d/10-mtrack.conf | sed 's/Dr.*/&\n    Option      "Sensitivity"   "0.35"/g' > /tmp/mtracktmp
sudo cp /tmp/mtracktmp /etc/X11/xorg.conf.d/10-mtrack.conf
sudo cp ~/.dotFiles/X/touchpad.conf /etc/X11/xorg.conf.d/70-synaptics.conf

#Auto-Start VPN
trizen -S openvpn --noconfirm
sudo cp ~/saveFolder/expressVPN.conf /etc/openvpn/client/express.conf
sudo cp saveFolder/ExVPN.pass /etc/openvpn/client/
sudo systemctl enable openvpn-client@express.service

#Vim German Spell Check
sudo vim +'set spell spelllang=en,de' +y +1 +q +q

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/haikarainen/light.git
cd light
sh autogen.sh
./configure
sudo make
sudo make install
cd ..
trash light

mv ~/dotFiles ~/.dotFiles
#Savefolder Files
cp ~/saveFolder/ssh ~/.ssh -r # Must do this before spark, because config will be overwritten otherwise
/bin/cp -r ~/saveFolder/.jarsNotToSave ~
cp -r ~/saveFolder/ssh ~/.ssh
crontab ~/saveFolder/listCrontab;
sudo /bin/cp  ~/saveFolder/hosts /etc/hosts;

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
echo "auth       sufficient   pam_wheel.so trust group=chsh" | cat - /etc/pam.d/chsh > /tmp/chsh # People in chsh group can change their shell without password -> automize better
sudo cp /tmp/chsh /etc/pam.d/chsh
sudo groupadd chsh
sudo usermod -a -G chsh nwuensche
chsh -s `which zsh`
#Just for super-user-spark
curl https://nixos.org/nix/install | sh
. /home/nwuensche/.nix-profile/etc/profile.d/nix.sh
nix-env --install super-user-spark #TODO Evnt selber bauen, um nix zu vermeiden
# For fzf in Vim
nix-env --install fd
~/.nix-profile/bin/spark -r deploy ~/.dotFiles/dotFiles.sus
~/.nix-profile/bin/spark -r deploy ~/saveFolder/saveFolder.sus
vim +PluginInstall +q +q
vim +PlugInstall +q +q

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
expect saveFolder/trustGPG Wuensche-N

/bin/cp ~/.dotFiles/terminalStuff/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

#Set TIMEOUT Grub down
cat /etc/default/grub | sed 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' > /tmp/grub #File data will be lost when piping directly back into the file
sudo cp /tmp/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

#Sync Time
trizen -S ntp --noconfirm
sudo systemctl enable ntpd
cat /etc/ntp.conf | sed 's/arch.pool/de.pool/g' > /tmp/tmpntp
sudo cp /tmp/tmpntp /etc/ntp.conf
sudo systemctl start ntpd



git clone https://github.com/NWuensche/android-app ~/wallabag
android-studio ~/wallabag #Download Android Stuff
steam #Download Updates

read "Press Enter if MFC5440CN is connected and powered, else cancel" 

sudo usermod -aG sys nwuensche #To allow user to print

mkdir /tmp/MFCInstall
wget http://download.brother.com/welcome/dlf006150/cupswrapperMFC5440CN-1.0.2-3.i386.deb -O /tmp/MFCInstall/cupsMFC.deb
wget http://download.brother.com/welcome/dlf006148/mfc5440cnlpr-1.0.2-1.i386.deb -O /tmp/MFCInstall/lprMFC.deb

cd /tmp/MFCInstall

ar x cupsMFC.deb
tar -xzvf control.tar.gz
tar -xzvf data.tar.gz

ar x lprMFC.deb
tar -xzvf control.tar.gz
tar -xzvf data.tar.gz

find . -type f -exec sed -i 's/printcap\.local/printcap/g' {} +
find . -type f -exec sed -i 's/\/bin\/csh/\/run\/current-system\/sw\/bin\/tcsh/g' {} +
find . -type f -exec sed -i 's/\/etc\/init.d\//\/etc\/rc.d\//g' {} +
find . -type f -exec sed -i 's/\/run\/current-system\/sw\/bin\/tcsh/\/usr\/bin\/tcsh/g' {} +
find . -type f -exec sed -i 's/DefaultPageSize: BrLetter/DefaultPageSize: BrA4/g' {} +

#sudo systemctl disable cups.service #Schlägt evnt fehl, da cups noch nicht init wurde. Dann einfach mit den nächsten Kommandos weiter machen
sudo systemctl enable org.cups.cupsd.service
sudo systemctl daemon-reload
sudo systemctl start org.cups.cupsd.service
sudo cp -rv usr /

sudo tcsh /usr/local/Brother/cupswrapper/cupswrapperMFC5440CN-1.0.2



clear
echo "Install Tmux Plugins with Prefix + I"
echo "Import Android Studio Settings"
echo "Change Paper Size to A4" #Maybe already fixed
