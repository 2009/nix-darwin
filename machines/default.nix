{
  pkgs,
  lib,
  config,
  home-manager,
  ...
}:

# Common configuration used by every machine.
{
  imports = [
    ../modules/emacs.nix # FIXME: (OSX) this installs emacs but we also install in brew.nix
  ];
  # zsh autocompletions for system packages
  # TODO: test this
  environment.pathsToLink = [ "/share/zsh" ];

  # use pkgs configured by nix-darwin/nixos
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = lib.mkIf pkgs.stdenv.isLinux true;

  # ----------------------------

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim

    pkgs.bat

    pkgs.source-code-pro
    pkgs.font-awesome

    pkgs.fasd
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
