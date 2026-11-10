#!/usr/bin/env bash
# Symlink the configs in this repo into place. Safe to re-run.
#
#   ./install.sh --dry-run   show what would change, touch nothing
#   ./install.sh             do it
#
# Anything already at a target path is moved to ~/.dotfiles-backup/<timestamp>/
# first, never deleted (that includes a whole existing ~/.config/nvim).
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
DRY=0
if [[ "${1:-}" == "--dry-run" ]]; then DRY=1; fi

run() {
  if (( DRY )); then echo "  [dry-run] $*"; else "$@"; fi
}

# link <path inside repo> <absolute target path>
link() {
  local src="$REPO/$1" dst="$2"

  if [[ ! -e "$src" ]]; then
    echo "skip   $1 (not in repo)"
    return
  fi
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok     $dst"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    echo "backup $dst -> $BACKUP/"
    run mkdir -p "$BACKUP"
    run mv "$dst" "$BACKUP/$(basename "$dst")"
  fi
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
  echo "link   $dst -> $src"
}

link .tmux.conf      "$HOME/.tmux.conf"
link starship.toml   "$HOME/.config/starship.toml"
link .aerospace.toml "$HOME/.aerospace.toml"
link nvim            "$HOME/.config/nvim"

echo
echo "Done. To pick up changes:"
echo "  tmux source-file ~/.tmux.conf"
echo "  aerospace reload-config"
