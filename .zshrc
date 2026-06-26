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
# 3. HOMEBREW PLUGINS
# ==============================================================================
# Enable zsh-autosuggestions (Provides grey ghost-text suggestions based on history)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable zsh-syntax-highlighting (Turns commands green/red based on validity)
# Note: This MUST remain at the very end of your .zshrc file to function properly.
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh