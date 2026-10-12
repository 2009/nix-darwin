{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:
let
  hasNvidiaDrivers = builtins.elem "nvidia" osConfig.services.xserver.videoDrivers;

  # hl.env(name, value) takes two arguments, so each entry renders via _args.
  mkEnv = name: value: { _args = [ name value ]; };

  browser = "chromium --new-window --ozone-platform=wayland";

  nvidiaEnv = [
    (mkEnv "NVD_BACKEND" "direct")
    (mkEnv "LIBVA_DRIVER_NAME" "nvidia")
    (mkEnv "__GLX_VENDOR_LIBRARY_NAME" "nvidia")
  ];
in
{
  # Kvantum Qt style for QT_STYLE_OVERRIDE below. Set here rather than via
  # home-manager's qt.style, which would also restyle Qt apps in Plasma.
  # Pick a theme with kvantummanager.
  home.packages = [
    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.libsForQt5.qtstyleplugin-kvantum
  ];

  wayland.windowManager.hyprland.settings = {
    # Programs, as Lua locals (used by the launcher submap in keybindings.nix).
    # `webapp` is built in Nix rather than referencing the `browser` local, so
    # it doesn't depend on the order Home Manager emits locals in.
    terminal = { _var = "ghostty"; };
    fileManager = { _var = "nautilus --new-window"; };
    browser = { _var = browser; };
    music = { _var = "spotify"; };
    passwordManager = { _var = "bitwarden"; };
    messenger = { _var = "signal-desktop"; };
    webapp = { _var = "${browser} --app"; };

    env = (lib.optionals hasNvidiaDrivers nvidiaEnv) ++ [
      (mkEnv "GDK_SCALE" "2")

      (mkEnv "XCURSOR_SIZE" "24")
      (mkEnv "HYPRCURSOR_SIZE" "24")

      (mkEnv "XCURSOR_THEME" "Adwaita")
      (mkEnv "HYPRCURSOR_THEME" "Adwaita")

      (mkEnv "GDK_BACKEND" "wayland")
      (mkEnv "QT_QPA_PLATFORM" "wayland")
      (mkEnv "QT_STYLE_OVERRIDE" "kvantum")
      (mkEnv "SDL_VIDEODRIVER" "wayland")
      (mkEnv "MOZ_ENABLE_WAYLAND" "1")
      (mkEnv "ELECTRON_OZONE_PLATFORM_HINT" "wayland")
      (mkEnv "OZONE_PLATFORM" "wayland")

      (mkEnv "CHROMIUM_FLAGS" "--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4")

      (mkEnv "EDITOR" "nvim")

      (mkEnv "GTK_THEME" "Adwaita:dark")
    ];

    # A list produces one hl.config(...) call per element, so each module can
    # contribute its own without the attrsets having to merge.
    config = [
      {
        xwayland = {
          force_zero_scaling = true;
        };

        ecosystem = {
          no_update_news = true;
        };
      }
    ];
  };
}
