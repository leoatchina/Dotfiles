#!/bin/bash
# Alacritty cross-platform environment setup for Linux/macOS

# Detect operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
    FONT_FAMILY="JetBrainsMono Nerd Font"
    FONT_SIZE="12"
    SHELL_PROGRAM="/bin/bash"
    SHELL_ARGS="[\"-l\"]"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
    FONT_FAMILY="JetBrainsMono Nerd Font"
    FONT_SIZE="13"
    SHELL_PROGRAM="/bin/zsh"
    SHELL_ARGS="[\"-l\"]"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

# Set environment variables
export ALACRITTY_OS="$OS_TYPE"
export ALACRITTY_FONT_FAMILY="$FONT_FAMILY"
export ALACRITTY_FONT_SIZE="$FONT_SIZE"
export ALACRITTY_SHELL="$SHELL_PROGRAM"
export ALACRITTY_SHELL_ARGS="$SHELL_ARGS"

echo "Alacritty environment variables set for $OS_TYPE:"
echo "ALACRITTY_OS=$ALACRITTY_OS"
echo "ALACRITTY_FONT_FAMILY=$ALACRITTY_FONT_FAMILY"
echo "ALACRITTY_FONT_SIZE=$ALACRITTY_FONT_SIZE"
echo "ALACRITTY_SHELL=$ALACRITTY_SHELL"
echo "ALACRITTY_SHELL_ARGS=$ALACRITTY_SHELL_ARGS"

# Add to shell profile
SHELL_CONFIG=""
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [[ -n "$SHELL_CONFIG" ]]; then
    echo ""
    echo "To make these settings permanent, add these lines to $SHELL_CONFIG:"
    echo "export ALACRITTY_OS=\"$ALACRITTY_OS\""
    echo "export ALACRITTY_FONT_FAMILY=\"$ALACRITTY_FONT_FAMILY\""
    echo "export ALACRITTY_FONT_SIZE=\"$ALACRITTY_FONT_SIZE\""
    echo "export ALACRITTY_SHELL=\"$ALACRITTY_SHELL\""
    echo "export ALACRITTY_SHELL_ARGS=\"$ALACRITTY_SHELL_ARGS\""
fi