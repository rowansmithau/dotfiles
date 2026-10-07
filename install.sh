#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
shopt -s dotglob nullglob

link() {
  local src="$1" dst="$2"
  # back up real files/dirs (ln -sfn can't replace a real dir)
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then mv "$dst" "$dst.bak"; fi
  ln -sfn "$src" "$dst"
}

for src in "$DIR"/.*; do
  name="$(basename "$src")"
  case "$name" in
    .|..) continue ;;
    .gitconfig) link "$src" "$HOME/$name" ;;
    .git*) continue ;;
    .config)
      mkdir -p "$HOME/.config"
      for sub in "$src"/*; do
        link "$sub" "$HOME/.config/$(basename "$sub")"
      done
      ;;
    *) link "$src" "$HOME/$name" ;;
  esac
done