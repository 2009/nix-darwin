{ config, pkgs, ... }:
{
  # Emacs and dependencies
  environment.systemPackages = with pkgs; [
    # required dependencies
    emacs
    git

    # doom deps
    # FIXME: there is some issue M1 and emacs not fining hombrew apps
    # this could cause issues for other command so should be sorted out
    # NOTE: move fd to brew to test this, projectile will error
    # https://github.com/doomemacs/doomemacs/issues/6612
    pkgs.ripgrep
    pkgs.fd
    pkgs.fontconfig
    pkgs.coreutils-prefixed # gls
    clang

    # doom nix
    nixfmt

    # doom golang
    gopls
    gomodifytags
    gotests
    gore

    # doom sh
    shfmt
    shellcheck

    # doom docker
    dockfmt

    # doom org
    # FIXME: this is only available for MacOS, need a way to check host and install
    #pngpaste # paste image from MacOS clipboard

    # doom roam
    graphviz # roam graph visualisation

    # doom markdown
    pandoc

    # fonts
    nerd-fonts.symbols-only
    symbola
  ];
}
