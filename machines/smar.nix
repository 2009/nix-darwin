{
  pkgs,
  lib,
  config,
  home-manager,
  ...
}:

let
  username = "jendacott";
  homeDir = "/Users/${username}";
  sourceDir = "${homeDir}/.config/nix-darwin";
in
{
  imports = [
    ./default.nix
    #../roles/m1.nix
    #../roles/defaults.nix
    #../roles/brew.nix
    #../roles/yabai.nix
    #../roles/network.nix
    #../modules/home-settings.nix
  ];

  # Set the nix-darwin config directory
  environment.etc."nix-darwin".source = sourceDir;

  # Define primary user for nix-darwim
  system.primaryUser = username;

  # Define user settings
  users.users.${username} = {
    description = "Justin Endacott";
    home = homeDir; # needed for home-manager to work

    # set users default shell
    shell = pkgs.zsh;
  };

  # Set home-manager configs for username
  home-manager.users.${username} = lib.mkMerge [
    (import ../modules/home.nix)
    {
      # Set custom zsh config for this machine only
      programs.zsh = {
        initExtra = ''
          # Claude Code
          # APAC Models: https://699475926481-rxrabrht.ap-southeast-2.console.aws.amazon.com/bedrock/home?region=ap-southeast-2#/inference-profiles
          export CLAUDE_CODE_USE_BEDROCK=1
          export ANTHROPIC_MODEL='arn:aws:bedrock:ap-southeast-2:699475926481:inference-profile/apac.anthropic.claude-3-7-sonnet-20250219-v1:0'
        '';

        shellAliases = {
          "claude-auth" =
            "export AWS_REGION=ap-southeast-2 ; export AWS_PROFILE=prod-eng-ai-sandbox ; aws sso login --profile prod-eng-ai-sandbox";
          sysr = "sudo darwin-rebuild switch --flake ${sourceDir}#smar";
          sysu = "nix flake update --flake ${sourceDir}";
          sysclean = "nix-collect-garbage -d ; sudo nix-collect-garbage -d";
        };
      };
    }
  ];

  # nix-darwin aliases
  # TODO need to figure out how to combine this wiht the import to home.nix
  # TODO maybe separate files of lib.mkMerge
  #home-manager.users.${username}.programs.zsh = {
  #  zsh-abbr = {
  #    abbreviations = {
  #      sysr = "darwin-rebuild switch --flake ${sourceDir}#.smar";
  #    };
  #  };
  #};

  # Set hostname
  #networking.hostName = "${hostname}";

  # ----------------------------

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Add Zscaler as a trusted root CA to avoid SSL errors
  # https://service.corp.smartsheet.com/support/solutions/articles/16000085512
  security.pki.certificates = [
    ''
      Zscaler Root CA
      ================
      -----BEGIN CERTIFICATE-----
      MIIE0zCCA7ugAwIBAgIJANu+mC2Jt3uTMA0GCSqGSIb3DQEBCwUAMIGhMQswCQYD
      VQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTERMA8GA1UEBxMIU2FuIEpvc2Ux
      FTATBgNVBAoTDFpzY2FsZXIgSW5jLjEVMBMGA1UECxMMWnNjYWxlciBJbmMuMRgw
      FgYDVQQDEw9ac2NhbGVyIFJvb3QgQ0ExIjAgBgkqhkiG9w0BCQEWE3N1cHBvcnRA
      enNjYWxlci5jb20wHhcNMTQxMjE5MDAyNzU1WhcNNDIwNTA2MDAyNzU1WjCBoTEL
      MAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExETAPBgNVBAcTCFNhbiBK
      b3NlMRUwEwYDVQQKEwxac2NhbGVyIEluYy4xFTATBgNVBAsTDFpzY2FsZXIgSW5j
      LjEYMBYGA1UEAxMPWnNjYWxlciBSb290IENBMSIwIAYJKoZIhvcNAQkBFhNzdXBw
      b3J0QHpzY2FsZXIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
      qT7STSxZRTgEFFf6doHajSc1vk5jmzmM6BWuOo044EsaTc9eVEV/HjH/1DWzZtcr
      fTj+ni205apMTlKBW3UYR+lyLHQ9FoZiDXYXK8poKSV5+Tm0Vls/5Kb8mkhVVqv7
      LgYEmvEY7HPY+i1nEGZCa46ZXCOohJ0mBEtB9JVlpDIO+nN0hUMAYYdZ1KZWCMNf
      5J/aTZiShsorN2A38iSOhdd+mcRM4iNL3gsLu99XhKnRqKoHeH83lVdfu1XBeoQz
      z5V6gA3kbRvhDwoIlTBeMa5l4yRdJAfdpkbFzqiwSgNdhbxTHnYYorDzKfr2rEFM
      dsMU0DHdeAZf711+1CunuQIDAQABo4IBCjCCAQYwHQYDVR0OBBYEFLm33UrNww4M
      hp1d3+wcBGnFTpjfMIHWBgNVHSMEgc4wgcuAFLm33UrNww4Mhp1d3+wcBGnFTpjf
      oYGnpIGkMIGhMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTERMA8G
      A1UEBxMIU2FuIEpvc2UxFTATBgNVBAoTDFpzY2FsZXIgSW5jLjEVMBMGA1UECxMM
      WnNjYWxlciBJbmMuMRgwFgYDVQQDEw9ac2NhbGVyIFJvb3QgQ0ExIjAgBgkqhkiG
      9w0BCQEWE3N1cHBvcnRAenNjYWxlci5jb22CCQDbvpgtibd7kzAMBgNVHRMEBTAD
      AQH/MA0GCSqGSIb3DQEBCwUAA4IBAQAw0NdJh8w3NsJu4KHuVZUrmZgIohnTm0j+
      RTmYQ9IKA/pvxAcA6K1i/LO+Bt+tCX+C0yxqB8qzuo+4vAzoY5JEBhyhBhf1uK+P
      /WVWFZN/+hTgpSbZgzUEnWQG2gOVd24msex+0Sr7hyr9vn6OueH+jj+vCMiAm5+u
      kd7lLvJsBu3AO3jGWVLyPkS3i6Gf+rwAp1OsRrv3WnbkYcFf9xjuaf4z0hRCrLN2
      xFNjavxrHmsH8jPHVvgc1VD0Opja0l/BRVauTrUaoW6tE+wFG5rEcPGS80jjHK4S
      pB5iDj2mUZH1T8lzYtuZy0ZPirxmtsk3135+CKNa2OCAhhFjE0xd
      -----END CERTIFICATE-----
    ''
  ];
}
