{ pkgs, ... }:

# Ruby development environment with rbenv
{
  programs.rbenv = {
    enable = true;
    enableZshIntegration = true;

    # Install ruby-build plugin for installing Ruby versions
    plugins = [
      {
        name = "ruby-build";
        src = pkgs.fetchFromGitHub {
          owner = "rbenv";
          repo = "ruby-build";
          rev = "v20260222";
          hash = "sha256-48xH7VQs6ytXBEwkD6Uyq7GcWCUTMengM6ShwhgPUYk=";
        };
      }
    ];
  };

  # Build dependencies needed for compiling Ruby versions
  home.packages = with pkgs; [
    gcc
    gnumake
    openssl
    readline
    zlib
  ];
}
