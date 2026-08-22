#!/bin/sh
# Link zap config into ~/.config/zap
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.config/zap
rm ~/.config/zap/config.toml || true
ln -sf "$DIR/config.toml" ~/.config/zap/config.toml && echo "=== zap config linked ==="
