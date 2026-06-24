# dotfiles

Personal macOS setup — terminal, shell prompt, packages, and system settings.
Captured from a MacBook Pro (Apple M5) so a new machine can be brought up with
one command.

## New machine

```sh
git clone https://github.com/yousefm/dotfiles.git ~/dotfiles
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

`macos-settings.sh` only writes settings that differ from macOS defaults, so it
mirrors this machine rather than imposing an opinionated baseline. It currently
covers:

- **Appearance** — fixed Dark mode.
- **Dock** — icon size 59, no recent apps, bottom-right hot corner → Quick Note.
- **Finder** — List view, new windows open Downloads, no empty-trash warning,
  hidden "Recent Tags".
- **Trackpad/pointer** — tap to click, faster tracking speed.
- **Screenshots** — saved to `~/My Drive/Pictures/Screenshots` (if Google Drive
  is mounted).

### Re-capturing settings

After changing something in System Settings, find the key it wrote with:

```sh
defaults read com.apple.dock        # or finder, screencapture, etc.
defaults read -g                    # global / NSGlobalDomain
```

then add the matching `defaults write` line to `macos-settings.sh`.
