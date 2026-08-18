#!/bin/sh
# Link omp agent config files into ~/.omp/agent
DIR="$(cd "$(dirname "$0")" && pwd)"
rm ~/.omp/agent/keybindings.yml || true
ln -sf "$DIR/agent/keybindings.yml" ~/.omp/agent/keybindings.yml && echo "=== omp keybindings linked ==="
[ ! -f ~/.omp/agent/config.yml ] && cp "$DIR/agent/config.yml" ~/.omp/agent  && echo "=== omp config copied ==="
