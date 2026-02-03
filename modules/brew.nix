{ config, ... }:

{
  # homebrew packages
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    #onActivation.cleanup = "zap"; # Uncomment this if you want all brew packages not defined in this file to be removed when updated
    brews = [
      "mas" # AppStore cli

      #{
      #  name = "emacs-mac";
      #  # NOTE: changes to args require manual uninstall to force a rebuild
      #  args = [ "with-modules" "with-native-compilation" ];
      #  link = true;
      #}

      {
        name = "emacs-plus";
        # NOTE: changes to args require manual uninstall to force a rebuild
        args = [ "with-native-comp" ];
        link = true;
      }

      "tfenv"
      "tgenv"
      "goenv"
      #"nvm"
      "volta"

      "rbenv"
      "ruby-build"

      "awscli"

      #"editorconfig"
    ];
    extraConfig = ''
      cask_args appdir: "~/Applications"
    '';
    taps = [
      # for `emacs-mac`
      #"railwaycat/emacsmacport"
      "d12frosted/emacs-plus"
    ];
    casks = [
      "keepingyouawake"
      "ghostty"

      "google-cloud-sdk"
    ];

    # AppStore applications
    masApps = {
      #"WiFi Explorer" = 494803304;
      #"Okta Extension App" = 1439967473;
      "AnkiApp Flashcards" = 689185915;
    };
  };
}
