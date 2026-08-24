#!/bin/sh
# Link zap keybindings into ~/.config/zap
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.config/zap
rm ~/.config/zap/keybindings.yaml || true
ln -sf "$DIR/keybindings.yaml" ~/.config/zap/keybindings.yaml && echo "=== zap keybindings linked ==="
