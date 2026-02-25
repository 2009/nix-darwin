{
  config,
  pkgs,
  wallpaper ? "1-Pawel-Czerwinski-Abstract-Purple-Blue.jpg",
  ...
}:
let
  wallpaperPath = "~/Pictures/Wallpapers/${wallpaper}";

  # hyprpaper's monitor wildcard doesn't apply wallpaper to monitors previously set
  # so we set it dynamically per-monitor via hyprctl instead.
  setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
    sleep 0.5
    hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[].name' | while read -r monitor; do
      hyprctl hyprpaper wallpaper "$monitor,${wallpaperPath}"
    done
  '';
in
{
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../config/wallpapers;
      recursive = true;
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        wallpaperPath
      ];
    };
  };
  wayland.windowManager.hyprland.settings = {
    exec = [
      "${setWallpaper}"
    ];
  };
}
