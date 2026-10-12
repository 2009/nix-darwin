{
  config,
  pkgs,
  nix-colors,
  ...
}:
let
  palette = config.colorScheme.palette;
  convert = nix-colors.lib.conversions.hexToRGBString;
  backgroundRgb = "rgb(${convert ", " palette.base00})";
  foregroundRgb = "rgb(${convert ", " palette.base05})";
  activeRgb = "rgb(${convert ", " palette.base0E})";
  emptyRgb = "rgb(${convert ", " palette.base04})";
in
{
  home.packages = [ pkgs.nerd-fonts.caskaydia-mono ];

  # For styling see:
  # https://github.com/Alexays/Waybar/wiki/Styling
  # https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#style
  home.file = {
    ".config/waybar/" = {
      source = ../../config/waybar;
      recursive = true;
    };
    ".config/waybar/theme.css" = {
      text = ''
        @define-color background ${backgroundRgb};

        window#waybar {
          background-color: ${backgroundRgb};
          color: ${foregroundRgb};
        }

        #workspaces button.empty {
          color: ${emptyRgb};
        }

        #workspaces button.active {
          font-weight: 800;
          color: ${activeRgb};
        }
      '';
    };
  };

  programs.waybar = {
    enable = true;
    # Started by graphical-session.target: restarts on crash, logs to
    # `journalctl --user -u waybar`, and reloads when the config changes.
    systemd.enable = true;
    # Pinned to an unreleased master commit because Waybar 0.15.0 (latest
    # stable) is incompatible with Hyprland 0.56's Lua config:
    #   - workspace clicks send legacy `dispatch workspace N`, which the Lua
    #     dispatcher rejects, so clicking a workspace does nothing;
    #   - it can't parse 0.56's workspace IPC schema (`type = "normal"`, no
    #     `id` on named workspaces), so new/named workspaces never appear.
    # Fixed upstream in Alexays/Waybar#5013 and #5324. Remove this override
    # once nixpkgs ships a Waybar release newer than 0.15.0.
    package = (pkgs.waybar.override { cavaSupport = false; }).overrideAttrs (old: {
      version = "0.15.0-unstable-2026-10-10";
      src = pkgs.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = "791da38eddca36c2cc7ed0f90a295e52a47ec6fe";
        hash = "sha256-wsqiS5XReYTOTgyK2GGUFzRdpJRKShNvNCU77U1tpIo=";
      };
      # Master added a ModemManager (mm-glib) module and changed how cava is
      # vendored; nixpkgs doesn't handle either yet and we use neither.
      mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dwwan=disabled" ];
      # versionCheckHook expects `version` in `waybar --version`, which still
      # reports the last tag for an untagged commit.
      doInstallCheck = false;
    });
    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "bluetooth"
          "network"
          "wireplumber"
          "cpu"
          "power-profiles-daemon"
          "battery"
        ];
        # Every module sets cursor = false so the bar shows the normal arrow
        # throughout. Workspace and tray buttons can't show the hand cursor (they
        # cover the module's cursor with their own), so the hand on the other
        # modules was inconsistent.
        "hyprland/workspaces" = {
          cursor = false;
          format = "{name}";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
          };
        };
        cpu = {
          cursor = false;
          interval = 5;
          format = "󰍛";
          on-click = "ghostty -e btop";
        };
        clock = {
          cursor = false;
          format = "{:%A %I:%M %p}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
        };
        network = {
          cursor = false;
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "ghostty -e nmcli";
        };
        battery = {
          cursor = false;
          interval = 5;
          format = "{capacity}% {icon}";
          format-discharging = "{icon}";
          format-charging = "{icon}";
          format-plugged = "󰚥";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "Charged 󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          states = {
            warning = 20;
            critical = 10;
          };
        };
        bluetooth = {
          cursor = false;
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueman-manager";
        };
        wireplumber = {
          cursor = false;
          "format" = "󰕾";
          format-muted = "󰝟";
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip-format = "Playing at {volume}%";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          max-volume = 150;
        };
        tray = {
          cursor = false;
          spacing = 13;
        };
        power-profiles-daemon = {
          cursor = false;
          format = "{icon}";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            power-saver = "󰡳";
            balanced = "󰊚";
            performance = "󰡴";
          };
        };
      }
    ];
  };
}
