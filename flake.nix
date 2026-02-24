{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      hyprland,
      nix-colors,
      home-manager,
      nix-darwin,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit hyprland home-manager;
        };

        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit nix-colors hyprland;
              theme = "tokyo-night";
            };
          }
          ./machines/resetti/default.nix
        ];
      };

      darwinConfigurations."old-macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          nix-darwin.modules.common
          ./machines/old-macbook.nix
          home-manager.darwinModules.home-manager
        ];
      };

      darwinConfigurations."smar" = nix-darwin.lib.darwinSystem {
        modules = [
          nix-darwin.modules.common
          ./machines/smar.nix
          home-manager.darwinModules.home-manager
        ];
      };
    };
}
