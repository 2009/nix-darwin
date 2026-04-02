# PLACEHOLDER: Generate actual hardware configuration on the target machine
#
# To generate the real hardware-configuration.nix:
# 1. Boot into NixOS installer on the homelab machine
# 2. Run: nixos-generate-config --root /mnt
# 3. Copy /mnt/etc/nixos/hardware-configuration.nix to this file
#
# This placeholder allows the flake to build, but won't work on real hardware.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  # Placeholder - replace with actual hardware config
  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
