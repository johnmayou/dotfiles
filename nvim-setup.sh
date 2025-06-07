#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.config/nvim"

echo "Linking Neovim config…"

mkdir -p "$(dirname "$TARGET")"

ln -sfn "$REPO_DIR/nvim" "$TARGET"

echo "Symlink created:"
ls -l "$TARGET"

echo "Done."
