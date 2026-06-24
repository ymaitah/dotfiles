#!/usr/bin/env bash
# macOS settings — a faithful snapshot of THIS machine's customizations.
# Only settings that differ from macOS defaults are written here, so applying
# this on a fresh machine reproduces the same behavior. Every command is
# idempotent; re-run it any time.
#
# Snapshot captured: 2026-06-24 (MacBook Pro, Apple M5).
#
# No `set -e`: if one `defaults` call fails we still want the rest to run.
set -uo pipefail

# Quit System Settings first so it doesn't clobber our changes on exit.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

###############################################################################
# Appearance
###############################################################################
# Fixed Dark mode (not auto light/dark switching).
defaults write -g AppleInterfaceStyle -string "Dark"

###############################################################################
# Dock
###############################################################################
# Icon size 59px (macOS default is 48).
defaults write com.apple.dock tilesize -int 59
# Don't show recent / suggested apps in the Dock.
defaults write com.apple.dock show-recents -bool false
# Hot corner: bottom-right opens Quick Note (14), no modifier key required.
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Finder
###############################################################################
# Use List view by default in Finder windows.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# New Finder windows open the Downloads folder.
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads/"
# Don't warn before emptying the Trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# Hide "Recent Tags" in the Finder sidebar.
defaults write com.apple.finder ShowRecentTags -bool false

###############################################################################
# Trackpad & pointer
###############################################################################
# Tap to click.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g com.apple.mouse.tapBehavior -int 1
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
# Tracking speed (0.875; macOS default is ~0.6875). Higher = faster.
defaults write -g com.apple.trackpad.scaling -float 0.875
defaults write -g com.apple.mouse.scaling -float 0.875

###############################################################################
# Screenshots
###############################################################################
# Save screenshots to Google Drive. This only applies if the folder exists
# (i.e. Google Drive is mounted); otherwise macOS keeps saving to the Desktop.
SCREENSHOT_DIR="$HOME/My Drive/Pictures/Screenshots"
if [ -d "$SCREENSHOT_DIR" ]; then
  defaults write com.apple.screencapture location -string "$SCREENSHOT_DIR"
fi

###############################################################################
# Apply
###############################################################################
for app in Dock Finder SystemUIServer; do
  killall "$app" >/dev/null 2>&1 || true
done
echo "✓ macOS settings applied. Some changes need a logout/restart to fully take effect."
