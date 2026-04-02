{ config, pkgs, ... }:

{
  # Homelab machine - hostname: blathers

  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader - UPDATE THIS based on your hardware
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # Change to your boot disk
  boot.loader.grub.useOSProber = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "blathers"; # homelab machine
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Australia/Brisbane";

  # Locale settings
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable X11 and Plasma Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keymap
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # DNS resolver
  services.resolved.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-mono
  ];

  # Direnv
  programs.direnv.enable = true;

  # User account
  users.users.zenchi = {
    isNormalUser = true;
    description = "Zenchi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    unzip
    gnumake
    ripgrep
    fd
    fzf
    eza
    alejandra

    # TUIs
    lazygit
    btop
    fastfetch

    # Development
    ffmpeg

    # AI
    claude-code

    zoxide
  ];

  system.stateVersion = "25.11";
}
