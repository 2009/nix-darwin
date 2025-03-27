{ pkgs, lib, config, home-manager, ... }:


let
  username = "jendacott";
in {
  imports = [
    ../modules/brew.nix
    #../roles/m1.nix
    #../roles/defaults.nix
    #../roles/brew.nix
    #../roles/yabai.nix
    #../roles/network.nix
    #../modules/home-settings.nix
  ];

  # Set the nix-darwin config directory
  environment.etc."nix-darwin".source = "/Users/${username}/.config/nix-darwin";

  # Define user settings
  users.users.${username} = {
    description = "Tintin";
    home = "/Users/${username}"; # needed for home-manager to work

    # set users default shell
    shell = pkgs.zsh;
  };

  # zsh autocompletions for system packages
  # TODO: test this
  environment.pathsToLink = [ "/share/zsh" ];

  # use pkgs configured by nix-darwin
  home-manager.useGlobalPkgs = true;

  # Set home-manager configs for username
  home-manager.users.${username} = import ../modules/home.nix;

  # Set hostname
  #networking.hostName = "${hostname}";

  # Always show menu bar on M2 Macbook Air 
  #system.defaults.NSGlobalDomain._HIHideMenuBar = lib.mkForce false;

  # ----------------------------

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # FIXME this does not work
  environment.systemPackages =
  [ pkgs.vim

    # TODO try these and pick one
    #pkgs.ghostty # Broken, using brew
    #pkgs.alacritty
    #pkgs.kitty

    # doom deps
    #pkgs.ripgrep
    #pkgs.fd
    pkgs.fontconfig
    pkgs.coreutils-prefixed # gls

    # doom nix
    pkgs.nixfmt-rfc-style

    # doom golang
    pkgs.gopls
    pkgs.gomodifytags
    pkgs.gotests
    pkgs.gore

    # doom sh
    pkgs.shfmt
    pkgs.shellcheck

    # doom docker
    pkgs.dockfmt

    # doom org
    pkgs.pngpaste # paste image from MacOS clipboard
    
    # doom roam
    pkgs.graphviz # roam graph visualisation

    # doom markdown
    pkgs.pandoc

    pkgs.bat

    pkgs.source-code-pro
    pkgs.font-awesome

    pkgs.fasd
  ];
  
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  
  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;
  
  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
