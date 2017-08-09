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
 
  virtualisation.virtualbox.guest.enable = true;
  boot.initrd.checkJournalingFS = false;
  services.sshd.enable = true;


  services.xserver.enable = true;
  services.xserver.layout = "euro";
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.windowManager.i3.enable = true;

  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     wget
     vim
     sudo
     i3
     chromium
     terminator
     jre
     openjdk
     git
     ((pkgs.callPackage /etc/nixos/nix-home-package.nix) { })
   ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
    extraGroups = ["wheel" "networkmanager" ];
    hashedPassword = "$6$Xq1B38LOXaM4y$kBFC49X..bv46F8mINe4O4tr5wJp2i92G0jAkkdBsGI1Wkn0CLnsSxw1bgBOJ2oDX6s6JDlrMOVLq5./RrU2m/";
  };
  security.sudo.wheelNeedsPassword = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}

