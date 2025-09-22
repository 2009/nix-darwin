{
  pkgs,
  lib,
  config,
  home-manager,
  ...
}:

{
  imports = [
    ../modules/brew.nix
  ];
  # zsh autocompletions for system packages
  # TODO: test this
  environment.pathsToLink = [ "/share/zsh" ];

  # use pkgs configured by nix-darwin
  home-manager.useGlobalPkgs = true;

  # Always show menu bar on M2 Macbook Air
  #system.defaults.NSGlobalDomain._HIHideMenuBar = lib.mkForce false;

  # ----------------------------

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim

    # doom deps
    # FIXME: there is some issue M1 and emacs not fining hombrew apps
    # this could cause issues for other command so should be sorted out
    # NOTE: move fd to brew to test this, projectile will error
    # https://github.com/doomemacs/doomemacs/issues/6612
    pkgs.ripgrep
    pkgs.fd
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
}
