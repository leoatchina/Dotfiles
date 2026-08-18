#!/bin/sh
# Link herdr config into ~/.config/herdr
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.config/herdr
rm ~/.config/herdr/config.toml || true
ln -sf "$DIR/config.toml" ~/.config/herdr/config.toml && echo "=== herdr config linked ==="
