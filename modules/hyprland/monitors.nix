{
  config,
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    "$terminal" = lib.mkDefault "ghostty";
    "$fileManager" = lib.mkDefault "nautilus --new-window";
    "$browser" = lib.mkDefault "chromium --new-window --ozone-platform=wayland";
    "$music" = lib.mkDefault "spotify";
    "$passwordManager" = lib.mkDefault "bitwarden";
    "$messenger" = lib.mkDefault "signal-desktop";
    "$webapp" = lib.mkDefault "$browser --app";

    monitor = [ ];
  };
}
