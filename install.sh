#!/usr/bin/env bash

# pacboof installation script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pacboof"
APPS_DIR="${HOME}/.local/share/applications"
THEME_SRC="$SCRIPT_DIR/pacboof.rasi"
THEME_DST="$CONFIG_DIR/pacboof.rasi"
DESKTOP_SRC="$SCRIPT_DIR/pacboof.desktop"
DESKTOP_DST="$APPS_DIR/pacboof.desktop"

echo "🚀 Installing pacboof..."

# Check dependencies
echo "Checking dependencies..."

if ! command -v rofi &>/dev/null; then
    echo "❌ Error: rofi is not installed"
    echo "Install it with: sudo pacman -S rofi"
    exit 1
fi

if ! command -v fzf &>/dev/null; then
    echo "❌ Error: fzf is not installed"
    echo "Install it with: sudo pacman -S fzf"
    exit 1
fi

echo "✅ Dependencies OK"

# Create directories
echo "Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"
mkdir -p "$APPS_DIR"

# Install main script
echo "Installing pacboof to $INSTALL_DIR..."
cp "$SCRIPT_DIR/pacboof" "$INSTALL_DIR/pacboof"
chmod +x "$INSTALL_DIR/pacboof"

# Install theme
if [[ ! -f "$THEME_DST" ]]; then
    echo "Installing rofi theme..."
    cp "$THEME_SRC" "$THEME_DST"
else
    echo "⚠️  Theme already exists, skipping..."
fi

# Install desktop file
echo "Installing desktop entry..."
cp "$DESKTOP_SRC" "$DESKTOP_DST"
chmod +x "$DESKTOP_DST"

# Update desktop database
if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$APPS_DIR" 2>/dev/null || true
fi

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  WARNING: $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

# Check for AUR helper
if command -v yay &>/dev/null; then
    echo "✅ AUR helper (yay) detected"
elif command -v paru &>/dev/null; then
    echo "✅ AUR helper (paru) detected"
else
    echo "⚠️  No AUR helper found (optional)"
    echo "   Install yay for AUR support: sudo pacman -S yay"
fi

echo ""
echo "✨ Installation complete!"
echo ""
echo "Run: pacboof"
echo "Or find it in your application menu!"
echo ""
echo "Enjoy! 🎉"

