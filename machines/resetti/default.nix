{ pkgs, home-manager, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/steam.nix
    ../default.nix
  ];

  home-manager.users.zenchi = {
    imports = [
      ../../modules/hyprland/default.nix
      ../../modules/ghostty.nix
      ../../modules/btop.nix
      ../../modules/home.nix
    ];
  };

  environment.systemPackages = with pkgs; [
    discord
    wineWow64Packages.waylandFull
  ];

  # Add user to docker group for non-root docker access
  # TODO remove duplication and test
  users.users.zenchi.extraGroups = [ "docker" ];
}
