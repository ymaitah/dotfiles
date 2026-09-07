#!/usr/bin/env bash
# macOS settings — a faithful snapshot of THIS machine's customizations.
# Selected explicitly stored preferences are written here. Unset preferences
# are left to macOS; this is not a full system backup. Every command is
# idempotent; re-run it any time.
#
# Snapshot captured: 2026-09-07 (MacBook Pro, Apple M5).
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
# Hot corner: bottom-right opens Quick Note (14).
defaults write com.apple.dock wvous-br-corner -int 14

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
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
# Tracking speed (0.875; macOS default is ~0.6875). Higher = faster.
defaults write -g com.apple.trackpad.scaling -float 0.875
defaults write -g com.apple.mouse.scaling -float 0.875

# Gesture preferences shared by the built-in and Bluetooth trackpads.
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
  defaults write "$domain" DragLock -bool false
  defaults write "$domain" Dragging -bool false
  defaults write "$domain" TrackpadRightClick -bool true
  defaults write "$domain" TrackpadCornerSecondaryClick -int 0
  defaults write "$domain" TrackpadThreeFingerDrag -bool false
  defaults write "$domain" TrackpadPinch -bool true
  defaults write "$domain" TrackpadRotate -bool true
  defaults write "$domain" TrackpadScroll -bool true
  defaults write "$domain" TrackpadHorizScroll -bool true
  defaults write "$domain" TrackpadMomentumScroll -bool true
  defaults write "$domain" TrackpadThreeFingerTapGesture -int 0
  defaults write "$domain" TrackpadTwoFingerDoubleTapGesture -int 1
  defaults write "$domain" TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
  for key in TrackpadThreeFingerHorizSwipeGesture TrackpadThreeFingerVertSwipeGesture TrackpadFourFingerHorizSwipeGesture TrackpadFourFingerVertSwipeGesture TrackpadFourFingerPinchGesture TrackpadFiveFingerPinchGesture; do
    defaults write "$domain" "$key" -int 2
  done
done
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false
defaults write -g com.apple.trackpad.forceClick -bool true

###############################################################################
# Keyboard & text
###############################################################################
# These are explicitly enabled on the source Mac. Repeat timing is unset.
defaults write -g NSAutomaticCapitalizationEnabled -bool true
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool true

###############################################################################
# Screenshots
###############################################################################
# Screenshot toolbar currently targets the clipboard in window capture mode.
defaults write com.apple.screencapture target -string "clipboard"
defaults write com.apple.screencapture style -string "window"
defaults write com.apple.screencapture video -bool false
# Remove the obsolete location from the previous snapshot, if present.
defaults delete com.apple.screencapture location >/dev/null 2>&1 || true

###############################################################################
# Apply
###############################################################################
for app in Dock Finder SystemUIServer; do
  killall "$app" >/dev/null 2>&1 || true
done
echo "✓ macOS settings applied. Some changes need a logout/restart to fully take effect."
