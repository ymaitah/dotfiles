#!/bin/bash

# --- Finder & Dock ---
# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Automatically hide the dock
defaults write com.apple.Dock autohide -bool true
# Remove the auto-hide delay (makes the dock appear instantly)
defaults write com.apple.Dock autohide-delay -float 0.0001

# --- Screenshots ---
# Change screenshot location from Desktop to Downloads folder
defaults write com.apple.screencapture location "$HOME/Downloads"

# --- System Behaviors ---
# Automatically switch between Light and Dark mode
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true
# Disable smart quotes (annoying when writing code)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Restart UI components to apply changes
killall Finder
killall Dock
echo "macOS settings applied!"