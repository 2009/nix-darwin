{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class .*, suppress_event maximize"

      # Force chromium into a tile to deal with --app bug
      "match:class ^(chromium)$, tile on"

      # Settings management
      "match:class ^(org.pulseaudio.pavucontrol|blueberry.py)$, float on"

      # Float Steam, fullscreen RetroArch
      "match:class ^(steam)$, float on"
      "match:class ^(com.libretro.RetroArch)$, fullscreen on"

      # Auto-assign apps to named workspaces (matching AeroSpace)
      "match:class ^(Slack)$, workspace name:S"
      "match:class ^(chromium)$, workspace name:B"
      "match:class ^(ghostty)$, workspace name:T"
      "match:class ^(podman-desktop)$, workspace name:D"
      "match:class ^(signal)$, workspace name:G"

      # Just dash of transparency
      "match:class .*, opacity 0.97 0.9"
      # Normal chrome Youtube tabs
      "match:class ^(chromium|google-chrome|google-chrome-unstable)$, match:title .*Youtube.*, opacity 1 1"
      "match:class ^(chromium|google-chrome|google-chrome-unstable)$, opacity 1 0.97"
      # Web apps
      "match:initial_class ^(chrome-.*-Default)$, opacity 0.97 0.9"
      # Youtube
      "match:initial_class ^(chrome-youtube.*-Default)$, opacity 1 1"
      "match:class ^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$, opacity 1 1"
      "match:class ^(com.libretro.RetroArch|steam)$, opacity 1 1"

      # Fix some dragging issues with XWayland
      "match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0, no_focus 1"

      # Float in the middle for clipse clipboard manager
      "match:class (clipse), float on"
      "match:class (clipse), size 622 652"
      "match:class (clipse), stay_focused on"
    ];

    layerrule = [
      # Proper background blur for wofi
      "match:namespace wofi, blur on"
      "match:namespace waybar, blur on"
    ];
  };
}
