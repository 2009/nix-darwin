{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Rules apply in order, so the opacity entries below stay in their original
    # sequence -- later ones deliberately override earlier ones.
    window_rule = [
      {
        name = "suppress-maximize";
        match.class = ".*";
        suppress_event = "maximize";
      }

      # Float Steam, fullscreen RetroArch
      {
        name = "float-steam";
        match.class = "^(steam)$";
        float = true;
      }
      {
        name = "fullscreen-retroarch";
        match.class = "^(com.libretro.RetroArch)$";
        fullscreen = true;
      }

      # Auto-assign apps to named workspaces (matching AeroSpace)
      {
        name = "ws-slack";
        match.class = "^(Slack)$";
        workspace = "name:S";
      }
      # Chromium goes to workspace B, forced into a tile to deal with --app bug
      {
        name = "chromium";
        match.class = "^(chromium)$";
        tile = true;
        workspace = "name:B";
      }
      {
        name = "ws-podman-desktop";
        match.class = "^(podman-desktop)$";
        workspace = "name:D";
      }
      {
        name = "ws-signal";
        match.class = "^(signal)$";
        workspace = "name:G";
      }

      # Just dash of transparency
      {
        name = "opacity-default";
        match.class = ".*";
        opacity = "0.97 0.9";
      }
      # Normal chrome Youtube tabs
      {
        name = "opacity-chrome-youtube";
        match = {
          class = "^(chromium|google-chrome|google-chrome-unstable)$";
          title = ".*Youtube.*";
        };
        opacity = "1 1";
      }
      {
        name = "opacity-chrome";
        match.class = "^(chromium|google-chrome|google-chrome-unstable)$";
        opacity = "1 0.97";
      }
      # Web apps
      {
        name = "opacity-webapps";
        match.initial_class = "^(chrome-.*-Default)$";
        opacity = "0.97 0.9";
      }
      # Youtube
      {
        name = "opacity-webapp-youtube";
        match.initial_class = "^(chrome-youtube.*-Default)$";
        opacity = "1 1";
      }
      {
        name = "opacity-media";
        match.class = "^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$";
        opacity = "1 1";
      }
      {
        name = "opacity-games";
        match.class = "^(com.libretro.RetroArch|steam)$";
        opacity = "1 1";
      }

      # Fix some dragging issues with XWayland
      {
        name = "fix-xwayland-drags";
        match = {
          class = "^$";
          title = "^$";
          xwayland = true;
          float = true;
          fullscreen = false;
          pin = false;
        };
        no_focus = true;
      }

      # Float in the middle for clipse clipboard manager
      # (CTRL+ALT+V opens it in Ghostty with --class=app.clipse; Ghostty needs a
      # dotted GTK app ID and ignores a bare "clipse".)
      {
        name = "clipse";
        match.class = "^(app.clipse)$";
        float = true;
        size = "622 652";
        stay_focused = true;
      }
    ];

    layer_rule = [
      # Proper background blur for wofi
      {
        name = "blur-wofi";
        match.namespace = "wofi";
        blur = true;
      }
    ];
  };
}
