{
  pkgs,
  lib,
  config,
  home-manager,
  ...
}:

let
  username = "jendacott";
  homeDir = "/Users/${username}";
  sourceDir = "${homeDir}/.config/nix-darwin";
in
{
  imports = [
    ../default.nix
    ../../modules/darwin/aerospace.nix
    ../../modules/darwin/brew.nix
  ];

  # Set the nix-darwin config directory
  environment.etc."nix-darwin".source = sourceDir;

  # Define user settings
  users.users.${username} = {
    description = "Tintin";
    home = homeDir; # needed for home-manager to work

    # set users default shell
    shell = pkgs.zsh;
  };

  # Set home-manager configs for username
  home-manager.users.${username} = import ../modules/home.nix;

  # Set hostname
  #networking.hostName = "${hostname}";

  # Always show menu bar on M2 Macbook Air
  #system.defaults.NSGlobalDomain._HIHideMenuBar = lib.mkForce false;

  # ----------------------------

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
