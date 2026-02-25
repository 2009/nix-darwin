{
  config,
  pkgs,
  nix-colors,
  hyprland,
  theme ? "tokyo-night",
  ...
}:
let
  themes = import ./themes.nix;
  selectedTheme = themes.${theme};
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./monitors.nix
    ./keybindings.nix
    ./autostart.nix
    ./envs.nix
    ./input.nix
    ./appearance.nix
    ./windows.nix
    ./lockscreen-hyprlock.nix
    ./wallpaper-hyprpaper.nix
    ./idle-hypridle.nix
    ./notifications-mako.nix
    ./statusbar-waybar.nix
    ./launcher-wofi.nix
    ./theme-viewer.nix
  ];

  colorScheme = nix-colors.colorSchemes.${selectedTheme.base16-scheme};

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;
  };

  home.packages = with pkgs; [
    hyprshot
    hyprpicker
    hyprsunset
    brightnessctl
    pamixer
    playerctl
    pavucontrol
    libnotify
    nautilus
    blueberry
    clipse
    wl-clipboard
    wl-clip-persist
    gnome-themes-extra
  ];

  services.hyprpolkitagent.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita:dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  programs.neovim.enable = true;

  home.file = {
    ".local/share/nix-config/bin" = {
      source = ../../config/bin;
      recursive = true;
    };
  };
}
