#!/bin/sh
# Link/copy pi config files into place.
# NOTE: pi-plan-mode.json MUST stay a real file — the extension opens it with
# O_NOFOLLOW and rejects symlinks ("settings path is not a regular file"),
# so it is copied, never linked.
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.pi/agent
rm ~/.pi/agent/keybindings.json || true
ln -sf "$DIR/agent/keybindings.json" ~/.pi/agent/keybindings.json && echo "=== pi keybindings linked ==="

# Link each Dotfiles-managed subagent without replacing unmanaged agent files.
mkdir -p ~/.pi/agent/agents
for agent_file in "$DIR"/agent/agents/*.md; do
    [ -f "$agent_file" ] || continue
    agent_name="$(basename "$agent_file")"
    agent_link="$HOME/.pi/agent/agents/$agent_name"
    if [ -L "$agent_link" ]; then
        rm -f "$agent_link"
    elif [ -e "$agent_link" ]; then
        echo "[WARN] Agent destination exists and is not a symlink, skipped: $agent_link"
        continue
    fi
    ln -s "$agent_file" "$agent_link" && echo "=== pi subagent linked: $agent_name ==="
done

rm -f ~/.pi/agent/pi-plan-mode.json
cp -f "$DIR/agent/pi-plan-mode.json" ~/.pi/agent/pi-plan-mode.json && echo "=== pi plan-mode settings copied (O_NOFOLLOW: real file) ==="

mkdir -p ~/.pi/agent/permission-mode
rm ~/.pi/agent/permission-mode/permission-mode.json || true
ln -sf "$DIR/agent/permission-mode.json" ~/.pi/agent/permission-mode/permission-mode.json && echo "=== pi permission-mode linked ==="

mkdir -p ~/.pi-lens
rm ~/.pi-lens/config.json || true
ln -sf "$DIR/pi-lens/config.json" ~/.pi-lens/config.json && echo "=== pi-lens config linked ==="

# Link each Dotfiles-managed skill without replacing real third-party skill directories.
mkdir -p ~/.agents/skills
for skill_dir in "$DIR"/skills/*; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    skill_link="$HOME/.agents/skills/$skill_name"
    if [ -L "$skill_link" ]; then
        rm -f "$skill_link"
    elif [ -e "$skill_link" ]; then
        echo "[WARN] Skill destination exists and is not a symlink, skipped: $skill_link"
        continue
    fi
    ln -s "$skill_dir" "$skill_link" && echo "=== pi skill linked: $skill_name ==="
done
