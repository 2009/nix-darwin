{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:
let
  hasNvidiaDrivers = builtins.elem "nvidia" osConfig.services.xserver.videoDrivers;
  nvidiaEnv = [
    "NVD_BACKEND,direct"
    "LIBVA_DRIVER_NAME,nvidia"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
  ];
in
{
  wayland.windowManager.hyprland.settings = {
    "$terminal" = lib.mkDefault "ghostty";
    "$fileManager" = lib.mkDefault "nautilus --new-window";
    "$browser" = lib.mkDefault "chromium --new-window --ozone-platform=wayland";
    "$music" = lib.mkDefault "spotify";
    "$passwordManager" = lib.mkDefault "bitwarden";
    "$messenger" = lib.mkDefault "signal-desktop";
    "$webapp" = lib.mkDefault "$browser --app";

    env = (lib.optionals hasNvidiaDrivers nvidiaEnv) ++ [
      "GDK_SCALE,2"

      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      "XCURSOR_THEME,Adwaita"
      "HYPRCURSOR_THEME,Adwaita"

      "GDK_BACKEND,wayland"
      "QT_QPA_PLATFORM,wayland"
      "QT_STYLE_OVERRIDE,kvantum"
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "OZONE_PLATFORM,wayland"

      "CHROMIUM_FLAGS,\"--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4\""

      "XDG_DATA_DIRS,$XDG_DATA_DIRS:$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share"

      "XCOMPOSEFILE,~/.XCompose"
      "EDITOR,nvim"

      "GTK_THEME,Adwaita:dark"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    ecosystem = {
      no_update_news = true;
    };
  };
}
