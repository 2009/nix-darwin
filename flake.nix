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
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

        specialArgs = {
          inherit hyprland home-manager;
        };

        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit nix-colors hyprland;
              theme = "onedark";
              wallpaper = "nord-1.png";
            };
          }
          ./machines/resetti/default.nix
        ];
      };

      nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit hyprland home-manager;
        };

        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit nix-colors hyprland;
              theme = "onedark";
              wallpaper = "ac-robo.png";
            };
          }
          ./machines/homelab/default.nix
        ];
      };

      darwinConfigurations."old-macbook" = nix-darwin.lib.darwinSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/old-macbook/default.nix
          home-manager.darwinModules.home-manager
        ];
      };

      darwinConfigurations."smar" = nix-darwin.lib.darwinSystem {
        modules = [
          ./machines/smar.nix
          home-manager.darwinModules.home-manager
        ];
      };
    };
}
