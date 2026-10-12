{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # NOTE: no mkDefault here -- `config` is a list contributed by several
    # modules, and a lower-priority definition would be dropped rather than
    # concatenated with the rest.
    config = [
      {
        input = {
          kb_layout = "us";
          kb_options = "compose:caps";

          follow_mouse = 1;

          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
          };
        };
      }
    ];
  };
}
