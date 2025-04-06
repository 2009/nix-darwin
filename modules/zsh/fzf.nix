{ pkgs, ... }:

{
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.fzf.enable
  # Finder (inside fzf) keybindings: https://github.com/junegunn/fzf?tab=readme-ov-file#using-the-finder
  # TODO: set Finder multi-select to CTRL+SPACE instead of TAB to match fzf-tab behaviour
  programs.fzf = {
    enable = true;
    # zsh integration keybindings: https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
    # CTRL-T: Paste selected files/dirs from the current dir tree
    # CTRL-R: Search zsh history
    # TODO changet CTRL+R to CTRL+H
    enableZshIntegration = true;

    # CTRL-T additional options
    fileWidgetOptions = [
      # Preview with bat or ls
      "--preview 'bat -n --color=always --line-range=:500 {} 2>/dev/null || ls {}'"
    ];
  };

  programs.zsh = {

    initExtra = ''
      # Disable default completion menu
      zstyle ':completion:*' menu no

      # Preview directory contents when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    '';

    plugins = [
      # Use fzf for tab completions
      # Keybindings: https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#usage
      {
        name = "fzf-tab";
        # will source fzf-tab.plugin.zsh
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.2.0";
          sha256 = "q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
        };
      }
    ];
  };
}
