{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;

  # hl.bind(keys, dispatcher [, opts]). Note that every modifier needs its own
  # "+" separator -- "ALT SHIFT + h" fails to parse.
  bind = key: dsp: { _args = [ key (mkLuaInline dsp) ]; };
  bindWith = key: dsp: opts: {
    _args = [
      key
      (mkLuaInline dsp)
      opts
    ];
  };

  locked = {
    locked = true;
  };
  lockedRepeat = {
    locked = true;
    repeating = true;
  };
  mouse = {
    mouse = true;
  };

  # Vim keys to Hyprland directions.
  directions = {
    h = "left";
    j = "down";
    k = "up";
    l = "right";
  };

  numbered = [
    1
    2
    3
    4
    5
    6
    7
    8
    9
  ];

  focusNamed = [
    "B"
    "C"
    "D"
    "E"
    "F"
    "G"
    "I"
    "M"
    "N"
    "O"
    "Q"
    "R"
    "S"
    "T"
    "U"
    "X"
    "Y"
    "Z"
  ];

  moveNamed = [
    "A"
    "B"
    "C"
    "D"
    "E"
    "F"
    "G"
    "I"
    "M"
    "N"
    "O"
    "P"
    "Q"
    "R"
    "S"
    "T"
    "U"
    "V"
    "W"
    "X"
    "Y"
    "Z"
  ];

  # Launcher submap entries: key -> command expression (Lua).
  launchEntries = {
    "a" = ''webapp .. "=https://chatgpt.com"'';
    "b" = "browser";
    "c" = ''webapp .. "=https://app.hey.com/calendar/weeks/"'';
    "d" = ''terminal .. " -e lazydocker"'';
    "e" = ''webapp .. "=https://app.hey.com"'';
    "f" = "fileManager";
    "g" = "messenger";
    "SHIFT + g" = ''webapp .. "=https://web.whatsapp.com/"'';
    "m" = "music";
    "p" = "passwordManager";
    "t" = ''terminal .. " -e btop"'';
    "y" = ''webapp .. "=https://youtube.com/"'';
    "k" = ''"~/.local/share/nix-config/bin/show-keybindings"'';
    "SHIFT + t" = ''"~/.local/share/nix-config/bin/show-themes"'';
  };
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Terminal
      (bind "SUPER + return" "hl.dsp.exec_cmd(terminal)")

      # Kill window
      (bind "ALT + W" "hl.dsp.window.close()")
      (bind "ALT + Backspace" "hl.dsp.window.close()")

      # Launcher
      (bind "SUPER + space" ''hl.dsp.exec_cmd("wofi --show drun --sort-order=alphabetical")'')
      (bind "ALT + SHIFT + SPACE" ''hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")'')

      # Session management
      # (bind "ALT + ESCAPE" ''hl.dsp.exec_cmd("hyprlock")'')
      (bind "ALT + SHIFT + ESCAPE" "hl.dsp.exit()")
      (bind "ALT + CTRL + ESCAPE" ''hl.dsp.exec_cmd("reboot")'')
      (bind "ALT + SHIFT + CTRL + ESCAPE" ''hl.dsp.exec_cmd("systemctl poweroff")'')

      # Tiling control
      (bind "ALT + slash" ''hl.dsp.layout("togglesplit")'')
      (bind "ALT + P" "hl.dsp.window.pseudo()")
      (bind "ALT + V" ''hl.dsp.window.float({ action = "toggle" })'')
      (bind "ALT + SHIFT + Plus" "hl.dsp.window.fullscreen()")

      # Resize
      (bind "ALT + minus" "hl.dsp.window.resize({ x = -50, y = 0, relative = true })")
      (bind "ALT + equal" "hl.dsp.window.resize({ x = 50, y = 0, relative = true })")
      (bind "ALT + SHIFT + minus" "hl.dsp.window.resize({ x = 0, y = -50, relative = true })")
      (bind "ALT + SHIFT + equal" "hl.dsp.window.resize({ x = 0, y = 50, relative = true })")

      # Workspace navigation
      (bind "ALT + comma" ''hl.dsp.focus({ workspace = "-1" })'')
      (bind "ALT + period" ''hl.dsp.focus({ workspace = "+1" })'')
      (bind "ALT + Tab" ''hl.dsp.focus({ workspace = "previous" })'')
      (bind "ALT + SHIFT + Tab" ''hl.dsp.workspace.move({ monitor = "+1" })'')

      # Special workspace
      (bind "ALT + grave" ''hl.dsp.workspace.toggle_special("magic")'')
      (bind "ALT + SHIFT + grave" ''hl.dsp.window.move({ workspace = "special:magic" })'')

      # Launch submap
      (bind "ALT + A" ''hl.dsp.submap("launch")'')

      # Mouse scroll workspaces
      (bind "ALT + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
      (bind "ALT + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')

      # Screenshots
      (bind "PRINT" ''hl.dsp.exec_cmd("hyprshot -m region")'')
      (bind "SHIFT + PRINT" ''hl.dsp.exec_cmd("hyprshot -m window")'')
      (bind "CTRL + PRINT" ''hl.dsp.exec_cmd("hyprshot -m output")'')
      (bind "ALT + PRINT" ''hl.dsp.exec_cmd("hyprpicker -a")'')

      # Clipse clipboard
      (bind "CTRL + ALT + V" ''hl.dsp.exec_cmd("ghostty --class=app.clipse -e clipse")'')
    ]
    # Vim-style focus
    ++ (lib.mapAttrsToList (
      key: dir: bind "ALT + ${key}" ''hl.dsp.focus({ direction = "${dir}" })''
    ) directions)

    # Vim-style move window
    ++ (lib.mapAttrsToList (
      key: dir: bind "ALT + SHIFT + ${key}" ''hl.dsp.window.move({ direction = "${dir}" })''
    ) directions)

    # Numbered workspaces
    ++ (map (n: bind "ALT + ${toString n}" "hl.dsp.focus({ workspace = ${toString n} })") numbered)

    # Named workspaces
    ++ (map (w: bind "ALT + ${w}" ''hl.dsp.focus({ workspace = "name:${w}" })'') focusNamed)

    # Move window to numbered workspace
    ++ (map (
      n: bind "ALT + SHIFT + ${toString n}" "hl.dsp.window.move({ workspace = ${toString n} })"
    ) numbered)

    # Move window to named workspace
    ++ (map (
      w: bind "ALT + SHIFT + ${w}" ''hl.dsp.window.move({ workspace = "name:${w}" })''
    ) moveNamed)

    # Lua has no bindm/bindel/bindl variants -- they are all hl.bind with an
    # options table.
    ++ [
      (bindWith "ALT + mouse:272" "hl.dsp.window.drag()" mouse)
      (bindWith "ALT + mouse:273" "hl.dsp.window.resize()" mouse)
    ]
    ++ [
      (bindWith "XF86AudioRaiseVolume"
        ''hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'' lockedRepeat
      )
      (bindWith "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")''
        lockedRepeat
      )
      (bindWith "XF86AudioMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")''
        locked
      )
      (bindWith "XF86AudioMicMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")''
        locked
      )
      (bindWith "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+")'' lockedRepeat)
      (bindWith "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-")''
        lockedRepeat
      )
    ]
    ++ [
      (bindWith "XF86AudioNext" ''hl.dsp.exec_cmd("playerctl next")'' locked)
      (bindWith "XF86AudioPause" ''hl.dsp.exec_cmd("playerctl play-pause")'' locked)
      (bindWith "XF86AudioPlay" ''hl.dsp.exec_cmd("playerctl play-pause")'' locked)
      (bindWith "XF86AudioPrev" ''hl.dsp.exec_cmd("playerctl previous")'' locked)
    ];
  };

  # onDispatch = "reset" leaves the submap after any dispatch, which replaces
  # the old "hyprctl dispatch submap reset && ..." prefix on every entry.
  wayland.windowManager.hyprland.submaps.launch = {
    onDispatch = "reset";
    settings.bind = (lib.mapAttrsToList (
      key: cmd: bind key "hl.dsp.exec_cmd(${cmd})"
    ) launchEntries)
    ++ [ (bind "escape" ''hl.dsp.submap("reset")'') ];
  };
}
