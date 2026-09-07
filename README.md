# dotfiles

Personal macOS setup — terminal, shell prompt, packages, and system settings.
Captured from a MacBook Pro (Apple M5) so a new machine can be brought up with
one command.

## New machine

```sh
git clone https://github.com/ymaitah/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh` is safe to re-run. It:

1. Installs the Xcode Command Line Tools (re-run after they finish).
2. Installs Homebrew and everything in the [`Brewfile`](Brewfile).
3. Symlinks config files into place (existing files are backed up):
   | Repo file | Linked to |
   | --- | --- |
   | `.zshrc` | `~/.zshrc` |
   | `starship.toml` | `~/.config/starship.toml` |
   | `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
   | `kitty/current-theme.conf` | `~/.config/kitty/current-theme.conf` |
4. Applies macOS settings via [`macos-settings.sh`](macos-settings.sh).

Because configs are **symlinked**, editing them in `~/dotfiles` updates the
live config (and vice-versa) — commit changes from here.

## What's in here

| File | Purpose |
| --- | --- |
| `bootstrap.sh` | One-shot installer for a fresh machine. |
| `Brewfile` | Homebrew formulae, casks, and fonts. |
| `macos-settings.sh` | macOS `defaults` (Dock, Finder, trackpad, etc.). |
| `.zshrc` | Zsh config (loads Starship). |
| `starship.toml` | Starship prompt (Tokyo Night). |
| `kitty/` | Kitty terminal config + theme. |

## macOS settings

`macos-settings.sh` captures selected preferences explicitly stored on this Mac,
last checked **2026-09-07**. Stored values are not necessarily customizations:
some match macOS defaults. Unset settings (including keyboard repeat timing,
Dock autohide, and Finder hidden-file visibility) are left to the destination
Mac. This is not a complete system backup. It currently covers:

- **Appearance** — fixed Dark mode.
- **Dock** — icon size 59, no recent apps, bottom-right hot corner → Quick Note.
- **Finder** — List view, new windows open Downloads, no empty-trash warning,
  hidden "Recent Tags".
- **Trackpad/pointer** — tap to click, tracking speed 0.875, secondary click,
  scrolling, zoom/rotation/swipe gestures, click pressure, and Force Click.
- **Keyboard/text** — automatic capitalization and period substitution enabled.
- **Screenshots** — clipboard destination and window capture mode; removes the
  obsolete Google Drive save-location preference.

Dock app order is intentionally excluded. Accounts, credentials, permissions,
and device-specific configuration must be set up separately. macOS versions
may interpret preferences differently; log out after applying and check System
Settings on the destination Mac.

The Brewfile includes the existing app selections plus currently installed
top-level tools and casks. Automatically installed library dependencies are
omitted. Shell and terminal configs were compared with their live copies;
the Bun completion path uses the destination user's home directory.

### Re-capturing settings

After changing something in System Settings, find the key it wrote with:

```sh
defaults read com.apple.dock        # or finder, screencapture, etc.
defaults read -g                    # global / NSGlobalDomain
```

then add the matching `defaults write` line to `macos-settings.sh`.
