#!/bin/bash

set -e #Exit after first non zero error code

function checkHDD {
    if [ ! -d /run/media/nwuensche/TOSHIBA\ EXT ]
    then
        echo "Mount external drive"
        exit 1
    fi
}

function importFiles {
    mkdir -p ~/Bilder
    mkdir -p ~/Dokumente
    mkdir -p ~/Downloads
    cp /run/media/nwuensche/TOSHIBA\ EXT/AufPC/* ~/ -r
    cp /run/media/nwuensche/TOSHIBA\ EXT/Bilder/Wallpaper.jpg ~/Bilder/
    cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/Master_Berlin ~/Dokumente/ -r
    cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/tud-cacert.pem ~/Dokumente/
    cp /run/media/nwuensche/TOSHIBA\ EXT/saveFolder ~ -r

    mv ~/dotFiles ~/.dotFiles
}

function setUpHome {
    checkHDD
    importFiles
}

function trizenPackages {
    sudo pacman -Syu --noconfirm
    git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si  --noconfirm #Install trizen
    # Remove vim to install gvim for better clipboard support
    trizen -R vim --noconfirm
    trizen -S jdk10-openjdk maven python3 git android-studio intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre `#Programming` \
        xorg xf86-video-intel lightdm lightdm-gtk-greeter i3-wm dmenu i3status i3lock `#UI` \ 
        gvim vim-spell-de vim-spell-en `#Vim`\
        xdotool expect `# Automation Tools`\
        tmux terminator zsh `#Terminator Environment`\
        curl wget htop neomutt vifm feh mps-youtube pdfgrep calcurse w3m bc mplayer irssi `#Terminal Tools`\
        pwgen xclip ffmpeg xss-lock xautolock youtube-dl trash-cli scrot udiskie ntfs-3g unrar cronie lynx ttf-liberation openssh imapfilter urlview `#Terminal Support Tools`\
        tcsh cups sane brscan2 brscan3`#Printer Tools`\
        xf86-input-synaptic xf86-input-mtrack `#Touchpad Tools`\
        ttf-liberation pango `#Fonts and Font Tools`\
        alsa-utils pulseaudio `#Audio`\
        steam calibre vlc gimp chromium kdenlive libreoffice-fresh-de  evince `#X Tools`\
        redshift gparted  arandr wine android-file-transfer notification-daemon `# X Support Tools`\
        virtualbox virtualbox-host-modules-arch virtualbox-guest-iso `#Virtualbox`\
        texlive-most biber texlive-localmanager-git `#Latex`\
        --noconfirm
}

function setUpBackgroundLight {
    git clone https://github.com/haikarainen/light.git
    cd light
    sh autogen.sh
    ./configure
    sudo make
    sudo make install
    cd ..
    trash light
}

function installZSH {
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    echo "auth       sufficient   pam_wheel.so trust group=chsh" | cat - /etc/pam.d/chsh > /tmp/chsh # People in chsh group can change their shell without password -> automize better
    sudo cp /tmp/chsh /etc/pam.d/chsh
    sudo groupadd chsh
    sudo usermod -a -G chsh nwuensche
    chsh -s `which zsh`

    /bin/cp ~/.dotFiles/terminalStuff/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme
}

function syncTime {
    trizen -S ntp --noconfirm
    sudo systemctl enable ntpd
    cat /etc/ntp.conf | sed 's/arch.pool/de.pool/g' > /tmp/tmpntp
    sudo cp /tmp/tmpntp /etc/ntp.conf
    sudo systemctl start ntpd
}

function installLatexTUDresden {
    tllocalmgr install tudscr
    tllocalmgr install opensans
    echo Y | tllocalmgr update chngcntr
    sudo texhash
}

function autoStartVPN {
    trizen -S openvpn --noconfirm
    sudo cp ~/saveFolder/expressVPN.conf /etc/openvpn/client/express.conf
    sudo cp saveFolder/ExVPN.pass /etc/openvpn/client/
    sudo systemctl enable openvpn-client@express.service
}

function installFonts {
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
}

function installPrograms {
    trizenPackages
    syncTime
    installZSH
    setUpBackgroundLight
    #installLatexTUDresden
    autoStartVPN
    installFonts
}

function fixDisplayManager {
    sudo sh -c 'echo "greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf' #Configure Display (Login) Manager
    sudo systemctl enable lightdm.service
}

function setGroups {
    sudo usermod -aG audio nwuensche #User is allowed to change audio
}

function fixTouchToClickTouchPad {
    cat /etc/X11/xorg.conf.d/10-mtrack.conf | sed 's/Dr.*/&\n    Option      "Sensitivity"   "0.35"/g' > /tmp/mtracktmp
    sudo cp /tmp/mtracktmp /etc/X11/xorg.conf.d/10-mtrack.conf
    sudo cp ~/.dotFiles/X/touchpad.conf /etc/X11/xorg.conf.d/70-synaptics.conf
}

function setUpVim {
    sudo vim +'set spell spelllang=en,de' +y +1 +q +q #German Spell Check

    #Vundle Install
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

function setUpTmux {
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function moveConfigs {
    cp ~/saveFolder/ssh ~/.ssh -r # Must do this before spark, because config will be overwritten otherwise
    /bin/cp -r ~/saveFolder/.jarsNotToSave ~
    cp -r ~/saveFolder/ssh ~/.ssh
    crontab ~/saveFolder/listCrontab;
    sudo /bin/cp  ~/saveFolder/hosts /etc/hosts;

    #Just for super-user-spark
    curl https://nixos.org/nix/install | sh
    . /home/nwuensche/.nix-profile/etc/profile.d/nix.sh
    nix-env --install super-user-spark #TODO Evnt selber bauen, um nix zu vermeiden
    ~/.nix-profile/bin/spark -r deploy ~/.dotFiles/dotFiles.sus
    ~/.nix-profile/bin/spark -r deploy ~/saveFolder/saveFolder.sus

    #Hard Link for every Script to be part of dmenu
    for fullfile in ~/.dotFiles/scripts/*; do
            filename=$(basename -- "$fullfile")
            ln -f $fullfile "/home/nwuensche/bin/$filename"
    done
    for fullfile in ~/saveFolder/privateScripts/*; do
            filename=$(basename -- "$fullfile")
            ln -f $fullfile "/home/nwuensche/bin/$filename"
    done

    gpg --import ~/saveFolder/gpg_key.asc
    expect saveFolder/trustGPG Wuensche-N

}

function setUpVimPlugins {
    vim +PluginInstall +q +q
    vim +PlugInstall +q +q
}

function lowerTimeoutGRUB {
    cat /etc/default/grub | sed 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' > /tmp/grub #File data will be lost when piping directly back into the file
    sudo cp /tmp/grub /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

function addConfigs { 
    fixDisplayManager 
    setGroups 
    fixTouchToClickTouchPad 
    autoStartVPN
    setUpVim
    setUpTmux
    moveConfigs
    setUpVimPlugins
    lowerTimeoutGRUB
}

function setUpMFC {
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
}

function setUpDCP {
    mkdir /tmp/DCPInstall
    wget http://download.brother.com/welcome/dlf005445/dcp145ccupswrapper-1.1.2-2.i386.deb -O /tmp/DCPInstall/cupsDCP.deb
    wget http://download.brother.com/welcome/dlf005443/dcp145clpr-1.1.2-2.i386.deb -O /tmp/DCPInstall/lprDCP.deb

    cd /tmp/DCPInstall

    ar x cupsDCP.deb
    tar -xzvf control.tar.gz
    tar -xzvf data.tar.gz

    ar x lprDCP.deb
    tar -xzvf control.tar.gz
    tar -xzvf data.tar.gz

    find . -type f -exec sed -i 's/printcap\.local/printcap/g' {} +
    find . -type f -exec sed -i 's/\/bin\/csh/\/run\/current-system\/sw\/bin\/tcsh/g' {} +
    find . -type f -exec sed -i 's/\/etc\/init.d\//\/etc\/rc.d\//g' {} +
    find . -type f -exec sed -i 's/\/run\/current-system\/sw\/bin\/tcsh/\/usr\/bin\/tcsh/g' {} +
    find . -type f -exec sed -i 's/DefaultPageSize: Letter/DefaultPageSize: A4/g' {} +

    sudo systemctl enable org.cups.cupsd.service
    sudo systemctl daemon-reload
    sudo systemctl start org.cups.cupsd.service
    sudo cp -rv usr /

    sudo sh /tmp/DCPInstall/usr/local/Brother/Printer/dcp145c/cupswrapper/cupswrapperdcp145c
}

function setUpPrinter {
    sudo usermod -aG sys nwuensche #To allow user to print

    while true; do
        read -p "Is MFC5440CN connected and powered? (y/n)" yn
        case $yn in
            [YyJj]* ) setUpMFC; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer y or n.";;
        esac
    done

    while true; do
        read -p "Is DCP145C connected and powered? (y/n)" yn
        case $yn in
            [YyJj]* ) setUpDCP; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

function setUpManually {
    git clone https://github.com/NWuensche/android-app ~/wallabag
    android-studio ~/wallabag #Download Android Stuff
    steam #Download Updates
}

function endMessages {
    clear
    echo "Install Tmux Plugins with Prefix + I"
    echo "Import Android Studio Settings"
}

#TODO Autostart WiFi Ding drin
#TODO install_arch_3
function main {
    setUpHome
    installPrograms
    addConfigs
    setUpPrinter
    setUpManually
    endMessages
}
main
