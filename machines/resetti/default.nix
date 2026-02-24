{ home-manager, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/docker.nix
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
}
