{ pkgs, ... }:

# Common home configuration to be included in home-manager.users.<username>
{
  imports = [
    ./zsh.nix
  ];

  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    userName = "Justin Endacott";
    userEmail = "justin.endacott@gmail.com";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
