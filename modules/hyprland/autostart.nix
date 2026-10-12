{ lib, ... }:
let
  inherit (import ./lua-helpers.nix { inherit lib; }) mkHook;
in
{
  # Long-running session services run as systemd user units tied to
  # graphical-session.target; waybar and hyprpolkitagent are enabled in their
  # own modules.
  services.hyprsunset.enable = true;

  wayland.windowManager.hyprland.settings = {
    on = [
      (mkHook "hyprland.start" [
        "wl-clip-persist --clipboard regular & clipse -listen"
      ])
    ];
  };
}
