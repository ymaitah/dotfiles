#!/usr/bin/env bash
# bootstrap.sh — set up a fresh Mac from this dotfiles repo.
#
#   1. Installs Xcode Command Line Tools (for git/compilers)
#   2. Installs Homebrew, then everything in the Brewfile
#   3. Symlinks config files (.zshrc, starship, kitty) into place
#   4. Applies macOS settings (macos-settings.sh)
#
# Safe to re-run: existing real files are backed up, symlinks are refreshed.
set -euo pipefail

# Absolute path to this repo, regardless of where the script is run from.
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
ok()   { printf '\033[1;32m  ✓\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m  !\033[0m %s\n' "$1"; }

###############################################################################
# 1. Xcode Command Line Tools
###############################################################################
if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  warn "Finish the CLT install in the popup, then re-run this script."
  exit 0
fi
ok "Xcode Command Line Tools present"

###############################################################################
# 2. Homebrew + packages
###############################################################################
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Make brew available in this session (Apple Silicon path).
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
ok "Homebrew ready"

info "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"
ok "Brewfile installed"

###############################################################################
# 3. Symlink config files
###############################################################################
# link <source-in-repo> <destination>
link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
    warn "backed up existing $dest"
  fi
  ln -s "$src" "$dest"
  ok "linked $(basename "$dest")"
}

info "Symlinking config files..."
link "$DOTFILES/.zshrc"                    "$HOME/.zshrc"
link "$DOTFILES/starship.toml"             "$HOME/.config/starship.toml"
link "$DOTFILES/kitty/kitty.conf"          "$HOME/.config/kitty/kitty.conf"
link "$DOTFILES/kitty/current-theme.conf"  "$HOME/.config/kitty/current-theme.conf"

###############################################################################
# 4. macOS settings
###############################################################################
info "Applying macOS settings..."
"$DOTFILES/macos-settings.sh"

echo
ok "Bootstrap complete. Log out and back in to finish applying all settings."
