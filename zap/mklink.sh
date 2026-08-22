#!/bin/sh
# Windows symlink script (Git Bash / MSYS2)
# Link zap config into Windows AppData / .config

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -W 2>/dev/null || pwd)"
TARGET_DIR="${APPDATA:-$USERPROFILE/AppData/Roaming}/zap"

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

# Source & destination paths
SRC_FILE="$SCRIPT_DIR/config.toml"
DST_FILE="$TARGET_DIR/config.toml"

# Convert to Windows style paths for cmd mklink
WIN_SRC="$(cygpath -w "$SRC_FILE" 2>/dev/null || echo "$SRC_FILE")"
WIN_DST="$(cygpath -w "$DST_FILE" 2>/dev/null || echo "$DST_FILE")"

# Remove existing file / link if present
rm -f "$DST_FILE" 2>/dev/null || true

# Create symbolic link via cmd.exe mklink
cmd.exe //c "mklink \"$WIN_DST\" \"$WIN_SRC\"" 2>/dev/null || cmd.exe /c "mklink \"$WIN_DST\" \"$WIN_SRC\""

if [ $? -eq 0 ]; then
    echo "=== zap config linked (Windows) ==="
else
    echo "[HINT] Run Git Bash as Administrator or enable Developer Mode on Windows."
fi
