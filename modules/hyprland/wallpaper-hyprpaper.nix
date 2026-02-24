{
  config,
  theme ? "tokyo-night",
  ...
}:
let
  themes = import ./themes.nix;
  wallpaperPath = "~/Pictures/Wallpapers/${themes.${theme}.wallpaper}";
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
      wallpaper = [
        ",${wallpaperPath}"
      ];
    };
  };
}
