{ nix-colors, theme ? "tokyo-night", ... }:
let
  themes = import ./themes.nix;
  activeScheme = themes.${theme}.base16-scheme;

  allSchemes = nix-colors.colorSchemes;
  schemeNames = builtins.attrNames allSchemes;
  maxNameLen = builtins.foldl' (acc: name:
    let len = builtins.stringLength name;
    in if len > acc then len else acc
  ) 0 schemeNames;

  baseKeys = [
    "base00" "base01" "base02" "base03" "base04" "base05" "base06" "base07"
    "base08" "base09" "base0A" "base0B" "base0C" "base0D" "base0E" "base0F"
  ];

  padRight = width: str:
    let
      len = builtins.stringLength str;
      padLen = if width > len then width - len else 0;
    in str + builtins.concatStringsSep "" (builtins.genList (_: " ") padLen);

  formatSchemeLine = schemeName:
    let
      palette = allSchemes.${schemeName}.palette;
      marker = if schemeName == activeScheme then "★" else " ";
      paddedName = padRight maxNameLen schemeName;
      swatches = builtins.concatStringsSep " " (map (key:
        let
          color = palette.${key};
          label = builtins.substring 4 2 key;
        in "<span foreground=\"#${color}\">██</span>${label}"
      ) baseKeys);
    in "${marker} ${paddedName}  ${swatches}";

  otherSchemes = builtins.filter (n: n != activeScheme) (builtins.sort builtins.lessThan schemeNames);
  orderedSchemes = [ activeScheme ] ++ otherSchemes;
  schemeListContent = builtins.concatStringsSep "\n" (map formatSchemeLine orderedSchemes);
in
{
  home.file.".local/share/nix-config/theme-list" = {
    text = schemeListContent;
  };
}
