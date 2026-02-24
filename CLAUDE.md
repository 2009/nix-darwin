# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix flake-based system configuration repo managing both NixOS (Linux) and nix-darwin (macOS) machines using home-manager for user environments. Hyprland desktop environment and theming are configured directly in `modules/hyprland/` using nix-colors for base16 color schemes.

## Build Commands

```sh
# NixOS (resetti machine) - rebuild and switch
sudo nixos-rebuild switch --flake .#nixos

# macOS (smar machine) - rebuild and switch
darwin-rebuild switch --flake .#smar

# Update flake inputs
nix flake update

# Garbage collect old generations
nix-collect-garbage -d
sudo nix-collect-garbage -d
```

## Architecture

**Flake structure:** The top-level `flake.nix` defines:
- `nixosConfigurations.nixos` — the "resetti" NixOS desktop (x86_64-linux)
- `darwinConfigurations.smar` / `darwinConfigurations.old-macbook` — macOS machines (aarch64-darwin)

**Flake inputs:**
- `hyprland` — Hyprland compositor from github:hyprwm/Hyprland
- `nix-colors` — base16 color scheme library from github:misterio77/nix-colors
- `home-manager` — user environment management
- `nix-darwin` — macOS system configuration

The `theme` value (e.g., `"tokyo-night"`) is passed to home-manager modules via `extraSpecialArgs` in `flake.nix`. The `hyprland` and `nix-colors` inputs are also passed via `specialArgs`/`extraSpecialArgs`.

**Machine configs** (`machines/`):
- `machines/default.nix` — shared base config imported by all machines (system packages, home-manager settings)
- `machines/resetti/` — NixOS desktop with NVIDIA GPU, KDE Plasma, Hyprland
- `machines/smar.nix` — macOS work machine (Smartsheet) with Bedrock/Claude config and Zscaler CA cert

**Modules** (`modules/`):
- `modules/home.nix` — common home-manager config (git, direnv, zoxide)
- `modules/zsh.nix` — shared zsh configuration (p10k, fzf, abbr, keybindings, history)
- `modules/ghostty.nix` — Ghostty terminal with nix-colors theming
- `modules/btop.nix` — btop system monitor with nix-colors theming
- `modules/emacs.nix` — Emacs setup
- `modules/nixos/` — NixOS-specific system modules (hyprland, audio, bluetooth, docker)
- `modules/darwin/` — macOS-specific modules (aerospace, homebrew)

**Hyprland modules** (`modules/hyprland/`):
- `default.nix` — imports all sub-modules, sets up nix-colors colorScheme, enables Hyprland
- `themes.nix` — theme name to base16 scheme + wallpaper mapping
- `keybindings.nix`, `autostart.nix`, `envs.nix`, `input.nix`, `appearance.nix`, `windows.nix`, `monitors.nix` — core Hyprland config
- `lockscreen-hyprlock.nix`, `wallpaper-hyprpaper.nix`, `idle-hypridle.nix`, `notifications-mako.nix`, `statusbar-waybar.nix`, `launcher-wofi.nix` — ecosystem services

**Static config** (`config/`):
- `config/waybar/` — Waybar CSS styles
- `config/wallpapers/` — Theme wallpaper images
- `config/bin/` — Helper scripts (e.g., keybinding viewer)

## Module Guidelines

- **Self-contained modules:** Every module must include all packages it depends on. Importing a module should just work without hunting for scattered dependencies.
- **NixOS-specific** system modules go in `modules/nixos/`, **Darwin-specific** in `modules/darwin/`.
- **Home-manager modules** go in `modules/` (cross-platform) or `modules/hyprland/` (Hyprland-specific).
- **Machine configs** (`machines/`) should compose modules, not define reusable config.
- `configuration.nix` is for machine-specific settings only (boot, hostname, locale, user accounts, machine-specific packages).

## Important Notes

- New files must be `git add`-ed (at least staged) before `nixos-rebuild`/`darwin-rebuild` can see them — flakes only copy tracked files to the Nix store.
- Theme colors are accessed via `config.colorScheme.palette` (from nix-colors) in any home-manager module imported alongside `modules/hyprland/default.nix`.
- The hardcoded `system = "x86_64-linux"` in flake.nix only applies to the NixOS config; Darwin configs set `nixpkgs.hostPlatform` independently.
