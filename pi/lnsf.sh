#!/bin/sh
# Link pi agent config files into ~/.pi/agent
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.pi/agent
rm ~/.pi/agent/keybindings.json || true
ln -sf "$DIR/agent/keybindings.json" ~/.pi/agent/keybindings.json && echo "=== pi keybindings linked ==="
rm ~/.pi/agent/pi-plan-mode.json || true
ln -sf "$DIR/agent/pi-plan-mode.json" ~/.pi/agent/pi-plan-mode.json && echo "=== pi plan-mode settings linked ==="
mkdir -p ~/.pi-lens
rm ~/.pi-lens/config.json || true
ln -sf "$DIR/pi-lens/config.json" ~/.pi-lens/config.json && echo "=== pi-lens config linked ==="
