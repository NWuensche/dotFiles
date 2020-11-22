#!/bin/bash

set -e #Exit after first non zero error code

function checkHDD {
    if [ ! -d /run/media/nwuensche/5f65b653-f040-40eb-a2de-64a7e4cac5c4 ]
    then
        echo "udiskie-mount external drive"
        exit 1
    fi
}


function importFiles {
    mkdir -p ~/Bilder
    mkdir -p ~/Dokumente
    mkdir -p ~/Downloads
    cp /run/media/nwuensche/TOSHIBA\ EXT/AufPC/* ~/ -r
    cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/Master_Berlin ~/Dokumente/ -r
    cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/tub-cacert.pem ~/Dokumente/
    cp /run/media/nwuensche/TOSHIBA\ EXT/Dokumente/Gesch* ~/Dokumente/
    cp /run/media/nwuensche/TOSHIBA\ EXT/saveFolder ~ -r

    mv ~/dotFiles ~/.dotFiles
}

function setUpHome {
    checkHDD
    importFiles
}

#Download by myself and not by AUR because updating is easier afterwards (inside IJ, not through AUR)
function installIJUltimate {
  OUT_IJ="/tmp/IJ.tar.gz"
  OUT_DIR="/opt/intellij"

  CURR_IJ=$(curl -s https://data.services.jetbrains.com/products/releases\?code\=IIU\&latest\=true\&type\=release | jq ".IIU[0].downloads.linux.link" | sed 's|"||g')

  echo "Downloading IntelliJ Ultimate"
  wget -q "$CURR_IJ" -O "$OUT_IJ"

  sudo mkdir -p "$OUT_DIR"
  sudo chmod 0777 "$OUT_DIR"
  sudo tar -xzf "$OUT_IJ" -C "$OUT_DIR" --strip-components=1 #strip parent dir inside tarball

}

function installIJCommunity {
    OUT_IJ="/tmp/IJ.tar.gz"
  OUT_DIR="/opt/intellij"

  CURR_IJ=$(curl -s https://data.services.jetbrains.com/products/releases\?code\=IIC\&latest\=true\&type\=release | jq ".IIC[0].downloads.linux.link" | sed 's|"||g')

  echo "Downloading IntelliJ Community"
  wget -q "$CURR_IJ" -O "$OUT_IJ"

  sudo mkdir -p "$OUT_DIR"
  sudo chmod 0777 "$OUT_DIR"
  sudo tar -xzf "$OUT_IJ" -C "$OUT_DIR" --strip-components=1 #strip parent dir inside tarball

  sudo chmod 0777 -R "$OUT_DIR" #New 2020.1 try
}

#Download by myself and not by AUR because updating is easier afterwards (inside AS, not through AUR)
function installAndroidStudio {
  OUT_AS="/tmp/AS.tar.gz"
  OUT_DIR="/opt/android-studio"

  URL_AS=$(curl -s "https://developer.android.com/studio/\#downloads" | sed -n '/p class="agreed"/,$ p' | sed -n 's/.*href="\(.*linux\.tar\.gz\)"/\1/pg'  | head -n 1)

  echo "Downloading Android Studio"
  wget -q "$URL_AS" -O "$OUT_AS"

  sudo mkdir -p "$OUT_DIR"
  sudo chmod 0777 "$OUT_DIR"
  sudo tar -xzf "$OUT_AS" -C "$OUT_DIR" --strip-components=1 #strip parent dir inside tarball

}

function yayPackages {
    sudo pacman -Syu --noconfirm
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si  --noconfirm && cd ~ && rm -rf yay #Install yay
    sudo yay -Syu --noconfirm
    yay -S ruby jdk-openjdk maven python3 gradle python-pip git hub --noconfirm #Programming
    yay -S xorg xf86-video-intel lightdm lightdm-gtk-greeter i3-wm dmenu i3status i3lock --noconfirm #UI
    yay -S gvim vim-spell-de vim-spell-en --noconfirm #Vim 
    yay -S pulseaudio-bluetooth bluez-utils bluez --noconfirm #Bluetooth
    yay -S xdotool expect --noconfirm # Automation Tools
    yay -S tmux terminator xterm zsh  --noconfirm #Terminator Environment 
    yay -S unzip curl mitmproxy wget ack progress htop offlineimap neomutt vifm feh pdfgrep calcurse w3m mplayer irssi docker stow --noconfirm #Terminal Tools 
    yay -S powertop python-selenium jq rsync pwgen xclip ffmpeg xss-lock xautolock trash-cli scrot udiskie	exfat-utils ntfs-3g unrar cronie ttf-liberation openssh imapfilter urlview pandoc-bin jpegoptim --noconfirm #Terminal Support Tools , pandoc-bin from AUR and not pandoc from community because I don't want 60 dynamic Haskell Library dependencies, but only the binary
    yay -S tcsh cups sane brscan2 brscan3 --noconfirm #Printer Tools 
    yay -S xf86-input-synaptics xf86-input-mtrack  --noconfirm #Touchpad Tools 
    yay -S xf86-input-wacom xbindkeys --noconfirm #Wacom Tablet Tools
    yay -S ttf-liberation pango  --noconfirm #Fonts and Font Tools 
    yay -S alsa-utils pulseaudio pavucontrol --noconfirm #Audio 
    yay -S steam sqlitebrowser calibre vlc gimp firefox kdenlive libreoffice-fresh-de  evince xournalpp zathura zathura-pdf-poppler spotify  --noconfirm #X Tools 
    yay -S wine lib32-libpulse --noconfirm # Wine stuff
    yay -S redshift gparted arandr android-file-transfer simple-mtpfs dunst  --noconfirm # X Support Tools 
    yay -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso  --noconfirm #Virtualbox 
    yay -S texlive-most biber texlive-localmanager-git  --noconfirm #Latex 
    yay -S slack-desktop openconnect telegram-desktop macchanger --noconfirm #Other Stuff 
    yay -S wpa_actiond --noconfirm # For auto search WiFi
    yay -S pdfjs --noconfirm # needed for pdf viewer qutebrowser


    gpg --keyserver hkp://keys.gnupg.net:80 --recv-keys  6113D89CA825C5CEDD02C87273B35DA54ACB7D10 #AUR of pass-tomb forgets to import this key
    yay -S pass-tomb --noconfirm

    pip install --user pytube pycurl #python-pytube in AUR is too old

    pacman -S python-configobj #Needed for terminator, else crash, also enables click on links again somehow


    gem install bluebutton #Own config for bluetooth button

    installIJCommunity
    installAndroidStudio

    sudo systemctl enable cronie.service #Enable Cron

    sudo systemctl enable org.cups.cupsd.service
    sudo systemctl start org.cups.cupsd.service

    sudo systemctl enable netctl-auto@wlp4s0.service
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
    expect ~/saveFolder/setchsh `which zsh`

    /bin/cp ~/.dotFiles/terminalStuff/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme
}

function syncTime {
    yay -S ntp --noconfirm
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
    sudo systemctl enable --now nordvpnsd
    systemctl --user enable --now nordvpnud
    sh ~/saveFolder/setupVPN.sh
    
}

function installFonts {
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
}


function loadWallabag {
    git clone https://github.com/NWuensche/android-app ~/wallabag
    cd wallabag
    git remote set-url origin https://github.com/wallabag/android-app
    git remote add upstream https://github.com/nwuensche/android-app
    cd ~
}

function installAnki {
  yay -S rustup protobuf --noconfirm # Build Tools for Anki
  sudo pip install maturin #Anki has forgotten to install this

  #Base Anki Installation
  TMP_TAR="/tmp/anki.tar.gz"
  TMP_OUT="/tmp/anki"
  OUT="/opt/anki"

  BASE_URL="https://github.com"
  LATEST_ANKI="$BASE_URL"
  #Release tar.bz2 doesn't have python files, so i cant use my import Script
  LATEST_ANKI+=$(curl -s https://github.com/ankitects/anki/releases | sed -n 's|.*href="\(.*.tar.gz\)".*|\1|gp' | head -n 1)

  curl -s -L "$LATEST_ANKI" --output - > "$TMP_TAR"
  #mkdir -p "$TMP_OUT"
  mkdir -p "$TMP_OUT"
  tar xzf "$TMP_TAR" -C "$TMP_OUT" --strip-components=1
  sudo cp -r "$TMP_OUT" "$OUT"
  sudo chmod -R 0777 "$OUT"
  ( cd "$OUT"
    cd pylib
    sed -i 's/patterns = .*/patterns = ";"/' anki/importing/csvfile.py #Only accept semicolon as delimiter
  )
  ( cd "$OUT"
    make develop #only `make` will also run the program + `make build` always has (for some reason) error 4 + `make develop` is everything except `make run`, which would open gui
    make clean
  )
  #Only Old Anki
  #( cd "$OUT"
  #  cd "qt" #Needed now
  #  sh "tools/build_ui.sh"
  #)

  #importCSV Script
  TMP_SCRIPT="/tmp/importAnki.py"
  curl -s -L https://github.com/NWuensche/AnkiTerminalImporter/raw/master/importAnki.py > "$TMP_SCRIPT"
  cp "$TMP_SCRIPT" "$OUT/pylib/importAnki.py"
  sudo chmod -R 0755 "$OUT"
}

function installPrograms {
    yayPackages
    syncTime
    installZSH
    setUpBackgroundLight
    #installLatexTUDresden
    installFonts
    loadWallabag
    installAnki #Need to do this manually because pacman anki conflicts with python pacakges
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

function wacomTabletConfig {
    sudo cp ~/.dotFiles/X/wacomTablet.conf /etc/X11/xorg.conf.d/72-wacom-options.conf
}

#Works for Firefox+Youtube and VLC
# Check https://www.youtube.com/watch?v=MfL_JkcEFbE for test
function fixScreenTearingIntelHDGraphics {
    sudo cp ~/.dotFiles/X/IntelHDGraphicsTearingFix.conf /etc/X11/xorg.conf.d/20-intel.conf
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
   # Needed for italic inside tmux
   tic ~/.dotFiles/terminalStuff/screen-256color.terminfo
}

function moveConfigs {
    cp ~/saveFolder/ssh ~/.ssh -r # Must do this before stow, because config will be overwritten otherwise
    cp -r ~/saveFolder/ssh ~/.ssh
    crontab ~/saveFolder/listCrontab;
    sudo /bin/cp  ~/saveFolder/hosts /etc/hosts;

    #TODO Vim could cause problem because I install plugins *afterwards*. If omnicomplete vim does not work, look if ftplugin and autoload folders in .vim folder correctly in
    ( cd $HOME/.dotFiles/stowConfigs; stow i3 wallpaper vim git terminal gpg programConfigs vifm podget X -t $HOME )
    sh ~/saveFolder/doStowSaveFolder.sh

    sudo ln -s /home/nwuensche/.dotFiles/X/my_dvorak  /usr/share/X11/xkb/symbols/my_dvorak

    sudo ln -s ~/.dotFiles/rules/99-udisks2.rules /etc/udev/rules.d
    sudo ln -s ~/.dotFiles/services/rfkill-own.service /etc/systemd/system/rfkill-own.service
    gpg --import ~/saveFolder/gpg_key_pub.asc
    gpg --import ~/saveFolder/gpg_key.asc
    expect ~/saveFolder/trustGPG Wuensche-N
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
    wacomTabletConfig
    fixScreenTearingIntelHDGraphics
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
    # New CUPS Versions don't allow Custom as a word in ppd file
    find . -type f -exec sed -i 's|.*Custom/Custom.*||g' {} +


    sudo systemctl disable cups.service || true #Schlägt evnt fehl, da cups noch nicht init wurde.
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
    echo Execute setUpManually Commands after reboot
    #android-studio ~/wallabag #Download Android Stuff
    #steam #Download Updates
    #chromium # Sync
    #echo "Install Tmux Plugins with Prefix + I (Shift + I)?" Should be unnecessary with new reloadTmux function
    echo "Import Android Studio Settings"
    echo "Import Firefox Bookmarks"
    echo "Run Android Studio and install Android, then run \`addUdevSmartphone\` script"
    echo "Import IntelliJ Community Settings"
    echo "Still works when error that Plugins subfolder is missing "
    echo "Maybe update Project Settings -> JDK to JDK 10 (from 13) if compilation error "
}


function fixWifi {
    sudo cp ~/saveFolder/services/fixwifi.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable fixwifi.service
    sudo cp ~/saveFolder/netctlProfiles/* /etc/netctl
}

function lidCloseLock {
    sudo cp ~/.dotFiles/services/lock@.service /etc/systemd/system/
    sudo systemctl daemon-reload
    systemctl enable lock@$USER.service
}

#Optimize Battery on startup
function powertopAdd {
    sudo cp ~/.dotFiles/services/powertop.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable powertop.service
    #TODO Does not work, Also with TLP_ENABLE=1 in conf
    #Also extra script with echo on in sys/bus does not help me
    #Needed to not auto-suspend USB Keyboard/Mouse, ids from lsusb
    yay -S tlp --noconfirm 
    sudo systemctl enable tlp.service
    sudo sh -c "echo -e 'USB_BLACKLIST=\"1bcf:0005\"\nUSB_BLACKLIST=\"04d9:a0cd\"' >> /etc/tlp.conf "
}

function fixAudio {
    #Default is that HDMI Out is default speaker. This makes normal speaker default
    sudo sh -c "echo -e \"pcm.\!default {\n        type hw\n        card 1\n}\" > /etc/asound.conf"
}

function reloadTmux {
  tmux new-session -d #Create tmux session without attaching so that source-file can be read by someone
  tmux source-file ~/.tmux.conf
}

function setUdevRules {
  $HOME/saveFolder/privateScripts/addUdevKeyboard
}

function disableWebcam {
  sudo sh -c "echo \"blacklist uvcvideo\" > /etc/modprobe.d/disable_webcam.conf"
}

function main {
    setUpHome
    installPrograms
    addConfigs
    fixWifi
    lidCloseLock
    #powertopAdd INFO Too many auto-suspend Mouse/keyboard problems that I cant solve + powertops give ~5 Minutes more lifetime with full battery, not worth it
    reloadTmux
    setUdevRules
    disableWebcam
    sh ~/saveFolder/setupScripts.sh
    #fixAudio Not Necessary
    setUpManually
    setUpPrinter
}

#main
setUpMFC
