rm ~/.omp/agent/keybindings.yml || true
rm ~/.omp/agent/config.yml || true
ln -sf "$(dirname "$0")/agent/keybindings.yml" ~/.omp/agent/keybindings.yml && echo "=== omp keybindings linked ==="
ln -sf "$(dirname "$0")/agent/config.yml" ~/.omp/agent/config.yml && echo "=== omp config linked ==="
