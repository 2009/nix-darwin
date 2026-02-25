{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Terminal
      "ALT, return, exec, $terminal"

      # Kill window
      "ALT, W, killactive,"
      "ALT, Backspace, killactive,"

      # Launcher
      "SUPER, space, exec, wofi --show drun --sort-order=alphabetical"
      "ALT SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"

      # Session management
      "ALT, ESCAPE, exec, hyprlock"
      "ALT SHIFT, ESCAPE, exit,"
      "ALT CTRL, ESCAPE, exec, reboot"
      "ALT SHIFT CTRL, ESCAPE, exec, systemctl poweroff"

      # Tiling control
      "ALT, slash, togglesplit,"
      "ALT, P, pseudo,"
      "ALT, V, togglefloating,"
      "ALT SHIFT, Plus, fullscreen,"

      # Vim-style focus
      "ALT, h, movefocus, l"
      "ALT, j, movefocus, d"
      "ALT, k, movefocus, u"
      "ALT, l, movefocus, r"

      # Vim-style move window
      "ALT SHIFT, h, movewindow, l"
      "ALT SHIFT, j, movewindow, d"
      "ALT SHIFT, k, movewindow, u"
      "ALT SHIFT, l, movewindow, r"

      # Resize
      "ALT, minus, resizeactive, -50 0"
      "ALT, equal, resizeactive, 50 0"
      "ALT SHIFT, minus, resizeactive, 0 -50"
      "ALT SHIFT, equal, resizeactive, 0 50"

      # Numbered workspaces
      "ALT, 1, workspace, 1"
      "ALT, 2, workspace, 2"
      "ALT, 3, workspace, 3"
      "ALT, 4, workspace, 4"
      "ALT, 5, workspace, 5"
      "ALT, 6, workspace, 6"
      "ALT, 7, workspace, 7"
      "ALT, 8, workspace, 8"
      "ALT, 9, workspace, 9"

      # Named workspaces
      "ALT, B, workspace, name:B"
      "ALT, C, workspace, name:C"
      "ALT, D, workspace, name:D"
      "ALT, E, workspace, name:E"
      "ALT, F, workspace, name:F"
      "ALT, G, workspace, name:G"
      "ALT, I, workspace, name:I"
      "ALT, M, workspace, name:M"
      "ALT, N, workspace, name:N"
      "ALT, O, workspace, name:O"
      "ALT, Q, workspace, name:Q"
      "ALT, R, workspace, name:R"
      "ALT, S, workspace, name:S"
      "ALT, T, workspace, name:T"
      "ALT, U, workspace, name:U"
      "ALT, X, workspace, name:X"
      "ALT, Y, workspace, name:Y"
      "ALT, Z, workspace, name:Z"

      # Workspace navigation
      "ALT, comma, workspace, -1"
      "ALT, period, workspace, +1"
      "ALT, Tab, workspace, previous"
      "ALT SHIFT, Tab, movecurrentworkspacetomonitor, +1"

      # Move window to numbered workspace
      "ALT SHIFT, 1, movetoworkspace, 1"
      "ALT SHIFT, 2, movetoworkspace, 2"
      "ALT SHIFT, 3, movetoworkspace, 3"
      "ALT SHIFT, 4, movetoworkspace, 4"
      "ALT SHIFT, 5, movetoworkspace, 5"
      "ALT SHIFT, 6, movetoworkspace, 6"
      "ALT SHIFT, 7, movetoworkspace, 7"
      "ALT SHIFT, 8, movetoworkspace, 8"
      "ALT SHIFT, 9, movetoworkspace, 9"

      # Move window to named workspace
      "ALT SHIFT, A, movetoworkspace, name:A"
      "ALT SHIFT, B, movetoworkspace, name:B"
      "ALT SHIFT, C, movetoworkspace, name:C"
      "ALT SHIFT, D, movetoworkspace, name:D"
      "ALT SHIFT, E, movetoworkspace, name:E"
      "ALT SHIFT, F, movetoworkspace, name:F"
      "ALT SHIFT, G, movetoworkspace, name:G"
      "ALT SHIFT, I, movetoworkspace, name:I"
      "ALT SHIFT, M, movetoworkspace, name:M"
      "ALT SHIFT, N, movetoworkspace, name:N"
      "ALT SHIFT, O, movetoworkspace, name:O"
      "ALT SHIFT, P, movetoworkspace, name:P"
      "ALT SHIFT, Q, movetoworkspace, name:Q"
      "ALT SHIFT, R, movetoworkspace, name:R"
      "ALT SHIFT, S, movetoworkspace, name:S"
      "ALT SHIFT, T, movetoworkspace, name:T"
      "ALT SHIFT, U, movetoworkspace, name:U"
      "ALT SHIFT, V, movetoworkspace, name:V"
      "ALT SHIFT, W, movetoworkspace, name:W"
      "ALT SHIFT, X, movetoworkspace, name:X"
      "ALT SHIFT, Y, movetoworkspace, name:Y"
      "ALT SHIFT, Z, movetoworkspace, name:Z"

      # Special workspace
      "ALT, grave, togglespecialworkspace, magic"
      "ALT SHIFT, grave, movetoworkspace, special:magic"

      # Launch submap
      "ALT, A, submap, launch"

      # Mouse scroll workspaces
      "ALT, mouse_down, workspace, e+1"
      "ALT, mouse_up, workspace, e-1"

      # Screenshots
      ", PRINT, exec, hyprshot -m region"
      "SHIFT, PRINT, exec, hyprshot -m window"
      "CTRL, PRINT, exec, hyprshot -m output"
      "ALT, PRINT, exec, hyprpicker -a"

      # Clipse clipboard
      "CTRL ALT, V, exec, ghostty --class clipse -e clipse"
    ];

    bindm = [
      "ALT, mouse:272, movewindow"
      "ALT, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    submap = launch
    bind = , a, exec, hyprctl dispatch submap reset && $webapp=https://chatgpt.com
    bind = SHIFT, a, exec, hyprctl dispatch submap reset && $webapp=https://grok.com
    bind = , b, exec, hyprctl dispatch submap reset && $browser
    bind = , c, exec, hyprctl dispatch submap reset && $webapp=https://app.hey.com/calendar/weeks/
    bind = , d, exec, hyprctl dispatch submap reset && $terminal -e lazydocker
    bind = , e, exec, hyprctl dispatch submap reset && $webapp=https://app.hey.com
    bind = , f, exec, hyprctl dispatch submap reset && $fileManager
    bind = , g, exec, hyprctl dispatch submap reset && $messenger
    bind = SHIFT, g, exec, hyprctl dispatch submap reset && $webapp=https://web.whatsapp.com/
    bind = , m, exec, hyprctl dispatch submap reset && $music
    bind = , n, exec, hyprctl dispatch submap reset && $terminal -e nvim
    bind = , o, exec, hyprctl dispatch submap reset && obsidian --disable-gpu
    bind = , p, exec, hyprctl dispatch submap reset && $passwordManager
    bind = , t, exec, hyprctl dispatch submap reset && $terminal -e btop
    bind = , x, exec, hyprctl dispatch submap reset && $webapp=https://x.com/
    bind = SHIFT, x, exec, hyprctl dispatch submap reset && $webapp=https://x.com/compose/post
    bind = , y, exec, hyprctl dispatch submap reset && $webapp=https://youtube.com/
    bind = , k, exec, hyprctl dispatch submap reset && ~/.local/share/nix-config/bin/show-keybindings
    bind = , escape, submap, reset
    submap = reset
  '';
}
