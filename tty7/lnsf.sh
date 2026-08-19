#!/bin/sh
# Link tty7 config into ~/.config/tty7
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.config/tty7
rm ~/.config/tty7/config.json || true
ln -sf "$DIR/config.json" ~/.config/tty7/config.json && echo "=== tty7 config linked ==="
