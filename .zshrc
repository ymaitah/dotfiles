# ==============================================================================
# 1. STARSHIP PROMPT
# ==============================================================================
# Initializes the Starship prompt (Tokyo Night theme configuration)
eval "$(starship init zsh)"

# ==============================================================================
# 2. AUTO-COMPLETION SETTINGS
# ==============================================================================
# Initialize the built-in Zsh completion system
autoload -Uz compinit && compinit

# Set auto-completion to be case-insensitive (e.g., cd dow -> cd Downloads)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ==============================================================================
# 3. SYSTEM PATHS & TOOLS
# ==============================================================================
# Claude CLI Path
export PATH="$HOME/.local/bin:$PATH"

# Bun installation & completions
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/yousefm/.bun/_bun" ] && source "/Users/yousefm/.bun/_bun"

# ==============================================================================
# 4. HOMEBREW PLUGINS (These must remain at the very bottom)
# ==============================================================================
# Enable zsh-autosuggestions (Provides grey ghost-text suggestions based on history)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable zsh-syntax-highlighting (Turns commands green/red based on validity)
# Note: This MUST remain at the very end of your .zshrc file to function properly.
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh