{ pkgs, ... }: {

  imports = [
    ./zsh.nix
    ./aerospace.nix
  ];

  # Home Manager version
  home.stateVersion = "24.11";

  # Enable Home Manager
  #programs.home-manager.enable = true;

  # Packages to install for the user
  #home.packages = with pkgs; [];

  # Programs configuration
  #programs = {
  #  git = {
  #    enable = true;
  #    userName = "Justin Endacott";
  #    # FIXME need to change this for work
  #    #userEmail = "justin.endacott@smartsheet.com";
  #    userEmail = "justin.endacott@gmail.com";
  #  };
  #};
}
