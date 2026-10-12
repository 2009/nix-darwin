# Helpers for building Hyprland Lua config entries. Not a module -- import with
# `import ./lua-helpers.nix { inherit lib; }`.
{ lib }:
let
  inherit (lib.generators) mkLuaInline toLua;
in
{
  # hl.on(event, fn) running each shell command via hl.exec_cmd. Lua has no
  # exec-once/exec keywords: use "hyprland.start" (once per session) and/or
  # "config.reloaded" (every reload). Commands are quoted with toLua, so they
  # may contain quotes or backslashes.
  mkHook = event: commands: {
    _args = [
      event
      (mkLuaInline ''
        function()
        ${lib.concatMapStringsSep "\n" (cmd: "  hl.exec_cmd(${toLua { } cmd})") commands}
        end'')
    ];
  };
}
