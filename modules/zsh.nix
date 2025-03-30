{ pkgs, ... }:
{

  imports = [
    ./zsh/p10k.nix
  ];

  # TODO: y to confirm for rm commands

  programs.zsh = {
    enable = true;

    # Enable this to profile zsh startup
    zprof.enable = false;

    # zsh tab completion for nix commands
    enableCompletion = true;

    # TODO: fuzzy tab completion https://superuser.com/questions/415650/does-a-fuzzy-matching-mode-exist-for-the-zsh-shell

    # FIXME: this is making tab completion funky
    # TODO: decide if we want suggstions or integrate with tab completion
    # https://github.com/zsh-users/zsh-autosuggestions#usage
    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };

    # TODO: custom patterns https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.syntaxHighlighting.patterns
    syntaxHighlighting.enable = true;

    # List of paths to autocomplete calls to cd
    #cdpath = [];

    # An attribute set that adds to named directory hash table
    # i.e. `cd ~docs`, `ls ~dls`
    dirHashes = {
      docs = "$HOME/Documents";
      dls = "$HOME/Downloads";
    };

    # "emacs", "vicmd" or "viins"
    # https://github.com/rothgar/mastering-zsh/blob/master/docs/usage/line_movement.md
    # TODO: try this modes
    #defaultKeymap = "vicmd";

    history = {
      append = true;
      # TODO: confirm how this works, is it needed when we don't save duplicates?
      # FIXME: sometimes history is removed without hitting enter?
      expireDuplicatesFirst = true;
      extended = true; # include timestamps

      # Do not display a line previously found in the history file
      # TODO: how does this work exactly?
      findNoDups = false;

      # If a new command line being added to the history list duplicates an older one,
      # the older command is removed from the list (even if it is not the previous event)
      ignoreAllDups = true;

      # Do not enter command lines into the history list if they match any one of the given shell patterns.
      #ignorePatterns = [ "rm *" "pkill *" ];

      # Share the history between sessions
      share = true;

      # Number of history lines to save
      save = 10000;
    };

    # TODO: historySubstringSearch to configure vim up and down in history
    # FIXME: this does not work how I expect and matches any substring, not just the start of the string
    historySubstringSearch = {
      enable = true;
    };

    # TODO: check out enhancd https://github.com/babarot/enhancd
    plugins = [
      #  {
      #    # will source zsh-autosuggestions.plugin.zsh
      #    name = "zsh-autosuggestions";
      #    src = pkgs.fetchFromGitHub {
      #      owner = "zsh-users";
      #      repo = "zsh-autosuggestions";
      #      rev = "v0.4.0";
      #      sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
      #    };
      #  }
      #  {
      #    name = "enhancd";
      #    file = "init.sh";
      #    src = pkgs.fetchFromGitHub {
      #      owner = "b4b4r07";
      #      repo = "enhancd";
      #      rev = "v2.2.1";
      #      sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
      #    };
      #  }
    ];

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      gcm = "git commit -m";
      gco = "git checkout";
    };

    # Similar to shellAliases, but are substituted anywhere on a line
    # TODO: could be useful
    #shellGlobalAliases = {
    #  UUID = "$(uuidgen | tr -d \\n)";
    #  G = "| grep";
    #};

    # TODO change emacs so it does not add text that is removed by ci"

    initExtra = ''
      # Load NVM and make it available
      export NVM_DIR="$HOME/.nvm"
      [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

      # Load goenv
      export GOENV_ROOT="$HOME/.goenv"
      export PATH="$GOENV_ROOT/bin:$PATH"
      eval "$(goenv init -)"
      export PATH="$GOROOT/bin:$PATH"
      export PATH="$PATH:$GOPATH/bin"
    '';

    # TODO checkout Mac Dash.app and opening man pages in it

    # Better aliases
    # TODO: try this
    zsh-abbr = {
      enable = true;
      abbreviations = {
        gco = "git checkout";
        gst = "git status";
        l = "less";
      };
    };
  };

  # TODO: do I need to install these?
  #home.packages = with pkgs; [
  #  zsh
  #  zsh-autosuggestions
  #  zsh-syntax-highlighting
  #];
}
