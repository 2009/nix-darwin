{
  config,
  wallpaper ? "1-Pawel-Czerwinski-Abstract-Purple-Blue.jpg",
  ...
}:
let
  wallpaperPath = "~/Pictures/Wallpapers/${wallpaper}";
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
