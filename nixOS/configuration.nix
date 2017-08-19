# Edit this configuration file to define what should be installed :wqon
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";


  networking.nameservers = [
    "8.8.8.8"
    "fe80::1%wlp4s0"
  ];
 
  virtualisation.virtualbox.guest.enable = true;
  boot.initrd.checkJournalingFS = false;

  programs.vim.defaultEditor = true;

  security.sudo.extraConfig = "nwuensche ALL=(root) NOPASSWD: /run/wrappers/bin/light-intel"; # Make background light working

  users.users.nwuensche.shell = pkgs.zsh;

  security.wrappers.light-intel = { source = pkgs.writeScript "light-intel" 
''
#!/bin/sh
CURR=$(cat /sys/class/backlight/intel_backlight/brightness)
echo $(($CURR+$1)) | sudo tee /sys/class/backlight/intel_backlight/brightness
''; 
owner = "root"; setuid = true; };

  hardware.trackpoint.emulateWheel = true;

  boot.loader.timeout = 0;
  networking.extraHosts = "
127.0.0.1 www.9gag.com
 127.0.0.1 9gag.com
127.0.0.1 https://9gag.com
127.0.0.1 www.youtube.com
127.0.0.1 www.instagram.com
127.0.0.1 www.facebook.com
  ";

# Mount everything in /media
   
  systemd.user.services.rfkill-own = {
   description = "RFKill-Block WLAN";
   serviceConfig = {
     Type = "idle";
     ExecStart = "/run/current-system/sw/bin/rfkill block wlan";
   };
   wantedBy = [ "multi-user.target" ];
 };
 systemd.services.rfkill-own.enable = true;

  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

   networking.hostName = "nixos"; # Define your hostname.
   networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
   i18n = {
  #   consoleFont = "Lat2-Terminus16";
      consoleKeyMap = "euro";
      defaultLocale = "de_DE.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     xz
     wget
     vim
     sudo
     i3
     chromium 
     terminator
     jre
     openjdk
     git
     jetbrains.idea-community
     android-studio
     hexchat
     htop
     ghc
     gparted
     gradle
     imagemagick
     geeqie
     curl
     ffmpeg
     evince
     gimp
     oh-my-zsh
     cron
     calibre
     audacity
     arandr
     cups
     aspell
     aspellDicts.de
     maven
     rubber #Latex
     mariadb
     libreoffice
     steam
     hibernate
     i3lock
     xss-lock
     xautolock
     xorg.xev
     jmtpfs # mtp with Android
     vimPlugins.vundle
     pwgen
     meslo-lg
     xclip
     dmenu
     thunderbird
     hunspell_1_6
     redshift
     pandoc
     phantomjs
     python36
     zsh
     unzip
     vifm
     virtualbox
     vlc
     #wine 
     #winetricks
     python35Packages.youtube-dl-light
     trash-cli
     truecrypt
     udiskie
     tdesktop #Telegram
     sshfs-fuse 
     super-user-spark 
     iw
     wpa_supplicant
     wpa_supplicant_gui
     i3status
     pamixer
     scrot
    #(pkgs.oh-my-zsh.overrideAttrs (oldAttrs: rec {
    #phases = "installPhase customThemePhase";
    #srcTheme = fetchurl {
        #url = "https://raw.githubusercontent.com/NWuensche/dotFiles/master/terminalStuff/agnoster.zsh-theme";
        #sha256 = "b99455c561bdcf9ec0601669da3d1aa680328ec1836430de22c6e7e32497ea5b";
    #};
    #customThemePhase = "
    #chmod +w $outdir/themes/agnoster.zsh-theme
    #cp $srcTheme $out/share/oh-my-zsh/themes/agnoster.zsh-theme
#";
  #}))
   ];

    programs.zsh = {
  enable = true;
        ohMyZsh = let 
      packages = [
        {
            owner = "nwuensche";
            repo = "dotFiles";
            rev = "6efde8b3fa744d1c9d6cd5bab9968000dbbf6303"; #Commit
            sha256 = "0n8xagqilkw13h20knb6by6ycpqjrx0qdjnpiaizbfkj8j5p4nyj";
        }
      ];

      fetchToFolder = { repo, ...}@attrs:
        pkgs.fetchFromGitHub (attrs // {
          extraPostFetch = ''
            tmp=$(mktemp -d)
            mv $out/* $tmp
            mkdir $out/${repo}
            mv $tmp/* $out/${repo}
          '';
        });
      custom = pkgs.buildEnv {
        name = "zsh-custom";
        paths = builtins.map fetchToFolder packages;
      };
    in
    {
      enable = true;
      custom = custom.outPath;
      theme = "dotFiles/terminalStuff/agnoster";
      plugins = [ "git" "pass" "brew" "colored-man" "colorize" ];
    };
};
  nixpkgs.config.allowUnfree = true; #For Steam
  hardware.opengl.driSupport32Bit = true; #For Steam
  hardware.pulseaudio.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.mutableUsers = false;

  users.extraUsers.nwuensche = {
    isNormalUser = true;
    home = "/home/nwuensche";
    description = "Niklas";
    extraGroups = ["wheel" "networkmanager" "cups"];
    hashedPassword = "$6$Xq1B38LOXaM4y$kBFC49X..bv46F8mINe4O4tr5wJp2i92G0jAkkdBsGI1Wkn0CLnsSxw1bgBOJ2oDX6s6JDlrMOVLq5./RrU2m/";
  };
  security.sudo.wheelNeedsPassword = true;

# Screen Locking (time-based & on suspend) + Keyboard

   services = {
    acpid = {
      enable = true;
      lidEventCommands = ''
        if grep -q closed /proc/acpi/button/lid/LID/state; then
          date >> /tmp/i3lock.log
          DISPLAY=":0.0" XAUTHORITY=/home/fadenb/.Xauthority ${pkgs.i3lock}/bin/i3lock &>> /tmp/i3lock.log
        fi
      '';
    };
    xserver = {
        videoDrivers = [  "intel"  ];
       deviceSection = ''
           Option      "Backlight"  "intel_backlight"
       '';
      enable = true;
      windowManager.i3.enable = true;
      synaptics.enable = true;
      multitouch.enable = true;
      synaptics.maxSpeed = "0.5";
      synaptics.minSpeed = "0.1"; 
       displayManager.sessionCommands = ''
            setxkbmap eu -option caps:escape
        #  ${pkgs.xautolock}/bin/xautolock -detectsleep -time 1 \
        #                -locker "${pkgs.i3lock}/bin/i3lock -c 000070" &
        #  ${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.i3lock}/bin/i3lock -c 000070 &
       '';
    };
    sshd.enable = true;
    udev.extraRules = ''
	ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"	
      '';
  printing.enable = true;
  printing.drivers = [ pkgs.splix ];
   };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
