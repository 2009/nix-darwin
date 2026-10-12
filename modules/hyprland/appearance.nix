{ config, ... }:
let
  hexToRgba =
    hex: alpha:
    "rgba(${hex}${alpha})";

  inactiveBorder = hexToRgba config.colorScheme.palette.base03 "aa";
  activeBorder = hexToRgba config.colorScheme.palette.base0D "aa";

  # hl.curve(name, spec) -- replaces the old "name,x1,y1,x2,y2" bezier strings.
  mkBezier = name: p1: p2: {
    _args = [
      name
      {
        type = "bezier";
        points = [
          p1
          p2
        ];
      }
    ];
  };
in
{
  wayland.windowManager.hyprland.settings = {
    config = [
      {
        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          col = {
            active_border = activeBorder;
            inactive_border = inactiveBorder;
          };

          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };

        decoration = {
          rounding = 4;

          shadow = {
            enabled = false;
            range = 30;
            render_power = 3;
            color = "rgba(00000045)";
          };

          blur = {
            enabled = true;
            size = 5;
            passes = 2;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          preserve_split = true;
          force_split = 2;
        };

        master = {
          new_status = "master";
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
      }
    ];

    # "curve" is in importantPrefixes, so these are emitted before the
    # hl.animation calls that reference them.
    curve = [
      (mkBezier "easeOutQuint" [ 0.23 1 ] [ 0.32 1 ])
      (mkBezier "easeInOutCubic" [ 0.65 0.05 ] [ 0.36 1 ])
      (mkBezier "linear" [ 0 0 ] [ 1 1 ])
      (mkBezier "almostLinear" [ 0.5 0.5 ] [ 0.75 1.0 ])
      (mkBezier "quick" [ 0.15 0 ] [ 0.1 1 ])
    ];

    animation = [
      {
        leaf = "global";
        enabled = true;
        speed = 10;
        bezier = "default";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 5.39;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windows";
        enabled = true;
        speed = 4.79;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 4.1;
        bezier = "easeOutQuint";
        style = "popin 87%";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 1.49;
        bezier = "linear";
        style = "popin 87%";
      }
      {
        leaf = "fadeIn";
        enabled = true;
        speed = 1.73;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeOut";
        enabled = true;
        speed = 1.46;
        bezier = "almostLinear";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 3.03;
        bezier = "quick";
      }
      {
        leaf = "layers";
        enabled = true;
        speed = 3.81;
        bezier = "easeOutQuint";
      }
      {
        leaf = "layersIn";
        enabled = true;
        speed = 4;
        bezier = "easeOutQuint";
        style = "fade";
      }
      {
        leaf = "layersOut";
        enabled = true;
        speed = 1.5;
        bezier = "linear";
        style = "fade";
      }
      {
        leaf = "fadeLayersIn";
        enabled = true;
        speed = 1.79;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeLayersOut";
        enabled = true;
        speed = 1.39;
        bezier = "almostLinear";
      }
      {
        leaf = "workspaces";
        enabled = false;
      }
    ];
  };
}
