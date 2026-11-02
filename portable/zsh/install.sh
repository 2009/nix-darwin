#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

brew bundle --file=Brewfile

for dotfile in .zshrc .zshenv .p10k.zsh; do
  [[ -e "$HOME/$dotfile" ]] && cp "$HOME/$dotfile" "$HOME/$dotfile.bak"
  cp "$dotfile" "$HOME/$dotfile"
done
mkdir -p "$HOME/.zsh" "$HOME/.config"
rm -rf "$HOME/.zsh/plugins" "$HOME/.config/zsh-abbr"
cp -R .zsh/plugins "$HOME/.zsh/plugins"
cp -R .config/zsh-abbr "$HOME/.config/zsh-abbr"
