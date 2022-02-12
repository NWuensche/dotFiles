#!/bin/bash

set -e #Exit after first non zero error code

CPU=$(cat /proc/cpuinfo | sed -n 's/.*\(Intel\|AMD\).*/\1/p' | head -n 1) #Intel or AMD

HDD="/run/media/nwuensche/5f65b653-f040-40eb-a2de-64a7e4cac5c4"
function checkHDD {
    if [ ! -d "$HDD" ]
    then
        echo "udiskie-mount external drive"
        exit 1
    fi
}


function importFiles {
    mkdir -p ~/Bilder
    mkdir -p ~/Dokumente
    mkdir -p ~/Downloads
    cp "$HDD"/AufPC/* ~/ -r || true

    cp "$HDD"/saveFolder ~ -r #Need saveFolder before Dokumente Restore

    echo "Restoring Dokumente, might take a while..."
    restoreDokumenteStructure

    mv ~/dotFiles ~/.dotFiles
}

#Copy exactly the files which were last on laptop, mkdir folder before copying file
function restoreDokumenteStructure {
  checkHDD
  PREFIX=$HOME
  STRUCTUREFOLDERS=$HOME/saveFolder/DokumenteFoldersStructure.txt
  STRUCTUREFILES=$HOME/saveFolder/DokumenteFilesStructure.txt
  SYMLINKFILES=$HOME/saveFolder/DokumenteFilesSymlinks.txt


  #Restore folders for safe mkdir (also create empty folders)
  #Read file without trimming whitespaces
  while IFS="" read -r FOLDERNAME || [ -n "$FOLDERNAME" ]
  do
    mkdir -p "$PREFIX/$FOLDERNAME" #Interpret Spaces correctly with quotes
  done < $STRUCTUREFOLDERS

  #Copy files
  #Read file without trimming whitespaces
  while IFS="" read -r FILENAME || [ -n "$FILENAME" ]
  do
    cp "$HDD/$FILENAME" -i "$PREFIX/$FILENAME" #Interpret Spaces correctly with quotes, dont override stuff with -i
  done < $STRUCTUREFILES

  #Restore Symlinks
  (  #Need to cd because else symlinks names are wrong (with "Dokumente" on front"
    cd $PREFIX/Dokumente/

    SYMTOORIG=$(cat $SYMLINKFILES) #link -> orig

    while read -r LINE; do
      SYM=$(echo "$LINE" | sed 's|^\(\S*\) -> \(\S*\)$|\1|' )
      if [[ -e "$SYM" ]]; then #Otherwise, ln -s can make weird shit with trying to make symlink on second parameter instead of first one (which is crazy)
        continue
      fi
      echo "$LINE" | sed 's|^\(\S*\) -> \(\S*\)$|ln -s \2/ \1|' |  xargs -I{} sh -c 'eval {}' #eval Does not work without sh for some reason
    done <<<  "$SYMTOORIG"
  )

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

  URL_AS=$(curl -s "https://developer.android.com/studio/\#downloads" | sed -n '/id="agreeLabel"/,$ p' | sed -n 's/.*href="\(.*linux\.tar\.gz\)"/\1/pg'  | head -n 1)

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
    sudo killall dirmngr || true #Else key import for tomb does not work
    yay -Rs vim --noconfirm || true #will conflict to gvim, thus when installed for debugging, we have to remove it
    yay -S ruby jdk-openjdk maven python3 gradle python-pip git hub --noconfirm #Programming
    yay -Rs acpilight --noconfirm || true #Just for sanity, when I restart script here, xorg would complain otherwise
    yay -S xorg xorg-xinit lightdm lightdm-gtk-greeter accountsservice i3-wm dmenu i3status i3lock plymouth --noconfirm #UI, accountsservice fixed lightdm warning, plymouth necessary for lightdm on AMD, xorg-xinit for startx

    #Makes problems when I install wrong one
    if [[ "$CPU" == "Intel" ]]; then
      yay -S xf86-video-intel --noconfirm
      yay -S intel-ucode --noconfirm #Will be enabled automatically when running grub-mkconfig next time
    fi
    if [[ "$CPU" == "AMD" ]]; then
      yay -S xf86-video-amdgpu --noconfirm
      yay -S amd-ucode --noconfirm #Will be enabled automatically when running grub-mkconfig next time

      #Fix backlight adjustment
      yay -Rs xorg-xbacklight --noconfirm || true
      yay -S acpilight --noconfirm
      sudo usermod -a -G video nwuensche
    fi

    yay -S gvim vim-spell-de vim-spell-en --noconfirm #Vim 
    yay -S xorg-xeyes sway swaylock swayidle bemenu-wayland wl-clipboard wdisplay wlr-randr grim slurp gammastep imv #wayland/sway stuff (grim+slurp = scrot, imv =feh)
    yay -S bluez-utils bluez --noconfirm #Bluetooth
    yay -S xdotool ydotool expect --noconfirm # Automation Tools
    yay -S tmux rxvt-unicode xterm zsh  --noconfirm #Terminator Environment 
    yay -S zip unzip trash-cli curl mitmproxy wget ack progress htop offlineimap neomutt vifm feh pdfgrep pdftk calcurse w3m mplayer irssi docker stow perl-image-exiftool --noconfirm #Terminal Tools 
    yay -S powertop python-selenium geckodriver jq rsync pwgen xclip ffmpeg xss-lock xautolock scrot udiskie	exfat-utils ntfs-3g unrar cronie ttf-liberation openssh imapfilter urlview pandoc-bin jpegoptim --noconfirm #Terminal Support Tools , pandoc-bin from AUR and not pandoc from community because I don't want 60 dynamic Haskell Library dependencies, but only the binary
    yay -S tcsh cups sane brscan2 brscan3 simple-scan --noconfirm #Printer Tools 
    yay -S xf86-input-synaptics xf86-input-mtrack  --noconfirm #Touchpad Tools 
    yay -S xf86-input-wacom xbindkeys --noconfirm #Wacom Tablet Tools
    yay -S ttf-liberation pango  --noconfirm #Fonts and Font Tools 
    yay -S alsa-utils pipewire-pulse pavucontrol pulsemixer --noconfirm #Audio, pipewire better with bluetooth than pulseaudio
    yay -S steam legendary sqlitebrowser calibre vlc gimp audacity firefox chromium kdenlive libreoffice-fresh-de  evince xournalpp zathura zathura-pdf-poppler  --noconfirm #X Tools 
    yay -S wine lib32-libpulse --noconfirm # Wine stuff
    yay -S redshift gparted arandr android-file-transfer simple-mtpfs dunst cheese  --noconfirm # X Support Tools 
    yay -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso  --noconfirm #Virtualbox 
    yay -S texlive-most biber tllocalmgr-git  --noconfirm #Latex 
    yay -S slack-desktop openconnect telegram-desktop signal-desktop macchanger --noconfirm #Other Stuff 
    yay -S wpa_actiond --noconfirm # For auto search WiFi
    yay -S qutebrowser pdfjs --noconfirm || true #Alternative browser, might fail because of python packages, pdfjs needed for pdf viewer qutebrowser
    yay -S lutris lib32-gnutls lib32-libpulse --noconfirm #lutris + programs for epic store TODO If still no sound, do https://www.reddit.com/r/wine_gaming/comments/7qm8wp/for_anyone_with_sound_issues_on_grand_theft_auto/
    yay -S libstdc++5 --noconfirm #needed for cups/printer
    yay -S ifplugd --noconfirm #LAN




    yay -S pass-tomb --noconfirm



#    gem install bluebutton #Own config for bluetooth button

    installIJCommunity
    installAndroidStudio

    sudo systemctl enable cronie.service #Enable Cron

    sudo systemctl enable cups.service
    sudo systemctl start cups.service

    if [[ "$CPU" == "Intel" ]]; then
      sudo systemctl enable netctl-auto@wlp4s0.service
    fi
    if [[ "$CPU" == "AMD" ]]; then
      #LAN
      sudo systemctl enable --now netctl-ifplugd@enp4s0f3u1u3.service
      #sudo systemctl enable --now dhcpcd@enp4s0f3u1u3.service Does block if no LAN https://wiki.archlinux.org/title/dhcpcd#dhcpcd@.service_causes_slow_startup
      sudo systemctl enable --now dhcpcd # Causes that WLAN is off by default + WiFi Crashes sometimes
      #WiFi
      sudo systemctl enable netctl-auto@wlo1.service
    fi
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
    sh ~/saveFolder/setupVPN.sh
}

function installFonts {
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
}

function installDependenciesCensorContent {
  yay -S tk --noconfirm
  sudo sed -i 's|<policy domain="delegate" rights="none" pattern="gs" />|<!-- <policy domain="delegate" rights="none" pattern="gs" /> -->|' /etc/ImageMagick-7/policy.xml #needed to convert pdf to png, else error
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
    #loadWallabag
    #installAnki #Need to do this manually because pacman anki conflicts with python pacakges
    installDependenciesCensorContent
}

function fixDisplayManager {
    sudo sed -i 's/^#greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf #Configure Display (Login) Manager, has to be directly under [Seat:*]
    sudo systemctl enable lightdm.service
    if [[ "$CPU" == "AMD" ]]; then
      sudo systemctl disable lightdm.service
      sudo systemctl enable lightdm-plymouth.service
    fi
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
function fixScreenTearingAndAMDDockingStation {
    if [[ "$CPU" == "Intel" ]]; then
      sudo cp ~/.dotFiles/X/IntelHDGraphicsTearingFix.conf /etc/X11/xorg.conf.d/20-intel.conf
    fi
    if [[ "$CPU" == "AMD" ]]; then
      sudo cp ~/.dotFiles/X/AMDTearingFix.conf /etc/X11/xorg.conf.d/20-amdgpu.conf
      fixDockingStationAMD
    fi
}

# Fixes HDMI on Dockingstation, see https://wiki.archlinux.org/title/intel_graphics#Installation (search `modesetting`)
# When using `amdgpu`, VGA works, but looks blurry (but might be faster?)
function fixDockingStationAMD {
  sudo sed 's/Driver "amdgpu"/Driver "modesetting"/' /etc/X11/xorg.conf.d/20-amdgpu.conf -i
}

function setUpTmux {
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   # Needed for italic inside tmux
   tic ~/.dotFiles/terminalStuff/screen-256color.terminfo
}

function moveConfigs {
    cp ~/saveFolder/ssh ~/.ssh -r -p # Must do this before stow, because config will be overwritten otherwise
    chmod 0700 ~/.ssh/id_b* # correct modifiers, matches public key as well
    chmod 0755 ~/.ssh/id_b*.pub #fix modifier public key back
    crontab ~/saveFolder/listCrontab;
    sudo /bin/cp  ~/saveFolder/hosts /etc/hosts;

    #TODO Vim could cause problem because I install plugins *afterwards*. If omnicomplete vim does not work, look if ftplugin and autoload folders in .vim folder correctly in
    rm -r .zshrc .bashrc .bash_profile .vim/ || true #Might have been created during debugging, would cause errors, problematic vim file is `.vim/autoload/plug.vim`
    #Create folders so that stow does not symlink whole folder
    mkdir -p ~/.vifm
    mkdir -p ~/.vim
    mkdir -p ~/.config/udiskie
    ( cd $HOME/.dotFiles/stowConfigs; stow i3 wallpaper vim git terminal gpg programConfigs vifm podget X -t $HOME )
    sh ~/saveFolder/doStowSaveFolder.sh

    sudo ln -s /home/nwuensche/.dotFiles/X/my_dvorak  /usr/share/X11/xkb/symbols/my_dvorak

    sudo ln -s ~/.dotFiles/rules/99-udisks2.rules /etc/udev/rules.d
    sudo ln -s ~/.dotFiles/services/rfkill-own.service /etc/systemd/system/rfkill-own.service
    gpg --import ~/saveFolder/gpg_key_pub.asc
    gpg --import ~/saveFolder/gpg_key.asc
    expect ~/saveFolder/trustGPG Wuensche-N

    mkdir -p ~/.cache/mutt/messages #Else mutt warnings
}

function setUpVimPlugins {
    sudo vim +'set spell spelllang=en,de' +y +1 +q +q #German Spell Check
    #Vundle Install - Unnecessary because now plug.vim in stow Config
    #curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    #    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +q +q
    vim +PlugInstall +q +q
}

function lowerTimeoutGRUB {
    cat /etc/default/grub | sed 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' > /tmp/grub #File data will be lost when piping directly back into the file
    sudo cp /tmp/grub /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

function addFirefoxProfile {
  timeout 10s firefox -headless || true #create profile for firefox without X + automatically close (will always return 1 when timeouted)
  rm -r ~/.mozilla/firefox/*.default-release/* #remove Anything inside old profile, but not folder itself (has to keep exact, random, name)
  cp -r ~/saveFolder/firefoxProfile/* ~/.mozilla/firefox/*.default-release/
}

function addConfigs { 
    #Not for wayland - fixDisplayManager 
    setGroups 
    fixTouchToClickTouchPad 
    wacomTabletConfig
    fixScreenTearingAndAMDDockingStation
    autoStartVPN
    setUpTmux
    moveConfigs
    setUpVimPlugins
    lowerTimeoutGRUB
    addFirefoxProfile
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
    sudo systemctl enable cups.service
    sudo systemctl daemon-reload
    sudo systemctl start cups.service
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

    sudo systemctl enable cups.service
    sudo systemctl daemon-reload
    sudo systemctl start cups.service
    sudo cp -rv usr /

    sudo sh /tmp/DCPInstall/usr/local/Brother/Printer/dcp145c/cupswrapper/cupswrapperdcp145c
}

function setUpPrinter {
    sudo usermod -aG sys nwuensche #To allow user to print

    while true; do
        read -p "Is MFC5440CN connected and powered? (y/n)" yn
        case $yn in
            [YyJj]* ) setUpMFC; break;;
            [Nn]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done

    while true; do
        read -p "Is DCP145C connected and powered? (y/n)" yn
        case $yn in
            [YyJj]* ) setUpDCP; break;;
            [Nn]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

function setUpManually {
    echo Execute setUpManually Commands after reboot
    #android-studio ~/wallabag #Download Android Stuff
    #steam #Download Updates
    #chromium # Sync
    echo "Install Tmux Plugins with Prefix + I (Shift + I)" #Should be unnecessary with new reloadTmux function, but TODO still is necessary
    echo "Import Android Studio Settings"
#   echo "Import Firefox Bookmarks"
#   echo "Start Firefox once, close it, remove  .mozilla/firefox/RANDOM.default-release folder completely and move firefoxProfile to it (RANDOM part has to match exactly with old folder!)"
    echo "Firefox: Set default Search Engine"
    echo "Run Android Studio and install Android, then run \`addUdevSmartphone\` script"
    echo "Import IntelliJ Community Settings"
    echo "Still works when error that Plugins subfolder is missing "
    echo "Maybe update Project Settings -> JDK to JDK 10 (from 13) if compilation error "
    echo "Firefox: Change default Search Engine (right one should be in list)"
    echo "Firefox: Import ublock filters"
    echo "Login Steam and Legendary(Epic)"
    echo "Remove install-scripts in /root/"
    echo "Check all important folders from Documents copied"
    echo "Clear USB-Stick"
}


function fixWifi {
    #different names for wifi modules
    if [[ "$CPU" == "Intel" ]]; then
      sudo cp ~/saveFolder/services/fixwifiintel.service /etc/systemd/system/fixwifi.service
    fi
    if [[ "$CPU" == "AMD" ]]; then
      sudo cp ~/saveFolder/services/fixwifiamd.service /etc/systemd/system/fixwifi.service
    fi
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
    sudo sh -c "echo -e \"pcm.!default {\n        type hw\n        card 1\n}\" > /etc/asound.conf"
}

function fixAudioAMD {
    #Default is that HDMI Out is default speaker. This makes normal speaker default, number from cat /proc/asound/cards
    sudo sh -c "echo -e \"pcm.!default {\n        type hw\n        card 3\n}\" > /etc/asound.conf"
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

function allowChangeCapsLockLED {
  sudo sed -i 's|!allowExplicit|allowExplicit|g' /usr/share/X11/xkb/compat/ledcaps || true #Allows setting LED with xset without root, used for microphone LED on AMD, dont fail for laptop without capslock LED
}

# https://wiki.archlinux.org/title/Laptop/Lenovo#Battery_Conservation_Mode_on_IdeaPad_laptops
function enableBatteryConservationModeIdeapad {
  isKernelModuleLoaded=$( lsmod | grep '^ideapad_laptop' || true )

  if [[ $isKernelModuleLoaded != "" ]]; then
    sudo sh -c 'echo 1 >/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'
  fi
}

function fixGrubStuffAMD {
  sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"$/GRUB_CMDLINE_LINUX_DEFAULT="\1 splash"/' /etc/default/grub #For some reason no `splash` screen option present

  # Fix Suspend wake up
  # From https://wiki.archlinux.org/index.php/Lenovo_IdeaPad_5_14are05
  yay -S acpica cpio --noconfirm
  DUMPFOLDER=$(mktemp -d)
  cd $DUMPFOLDER
  sudo acpidump -b
  iasl -e *.dat -d dsdt.dat
  iasl -e *.dat -d dsdt.dat
  curl 'https://gist.githubusercontent.com/zurohki/4b859668c901e6ba13e8187a0d5d734c/raw/a04e217f273630cfae8ab3aa82002e99b9b039d5/dsdt.patch' > dsdt.patch
  patch -p1 < dsdt.patch
  iasl -ve -tc dsdt.dsl
  mkdir -p kernel/firmware/acpi
  cp dsdt.aml kernel/firmware/acpi
  find kernel | cpio -H newc --create > acpi_override
  sudo cp acpi_override /boot
  sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"$/GRUB_CMDLINE_LINUX_DEFAULT="\1 mem_sleep_default=deep"/' /etc/default/grub
  sudo sh -c 'echo "GRUB_EARLY_INITRD_LINUX_CUSTOM=acpi_override" >> /etc/default/grub'
  #Dont need echo deep > /sys/power/mem_sleep, because grub option is already 'mem_sleep_default=!deep!'

  #Fix Suspend Brightness can be read (fixes journalctl error, but did not notice)
  sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"$/GRUB_CMDLINE_LINUX_DEFAULT="\1 acpi_backlight=vendor"/' /etc/default/grub

  #Fix journalctl error with virtalization (not noticed) (not fixed with iommu=pt)
  #Neither amd_iommu=on nor iommu=pt fix `amd_iommu=on fixed acp_pdm_mach acp_pdm_mach.0: snd_soc_register_card(acp) failed: -517`, but  Only sound issue, see package of github linux kernel (sometimes there, sometimes not)
  sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"$/GRUB_CMDLINE_LINUX_DEFAULT="\1 iommu=soft"/' /etc/default/grub


  sudo grub-mkconfig -o /boot/grub/grub.cfg
}


function main {
    if [[ "$CPU" != "Intel" && "$CPU" != "AMD" ]]; then
      echo "Don't know your CPU!"
      exit 1
    fi
    setUpHome
    installPrograms
    addConfigs
    fixWifi
    #lidCloseLock only needed x11
    #powertopAdd INFO Too many auto-suspend Mouse/keyboard problems that I cant solve + powertops give ~5 Minutes more lifetime with full battery, not worth it
    if [[ "$CPU" == "AMD" ]]; then
      fixGrubStuffAMD
    fi
    reloadTmux
    setUdevRules
    disableWebcam
    allowChangeCapsLockLED
    sh ~/saveFolder/setupScripts.sh
    if [[ "$CPU" == "AMD" ]]; then
      fixAudioAMD
    fi
    enableBatteryConservationModeIdeapad
    #fixAudio Not Necessary
    #master
    setUpPrinter
    setUpManually
}
#main
#setUpMFC
#installIJCommunity
#installAndroidStudio
#setUpDCP
#setUpMFC
#installAndroidStudio
#disableWebcam
#enableBatteryConservationModeIdeapad
#fixAudioAMD
#setUpPrinter
#enableBatteryConservationModeIdeapad
#fixScreenTearingAndAMDDockingStation
installAndroidStudio
