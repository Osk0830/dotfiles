# ==================================================
# ~/.zshrc
# ==================================================
# 開発用シェル設定
#
# PATH priority:
# 1. macOS system
# 2. Homebrew
# 3. asdf
# 4. user local
# 5. VS Code CLI
# ==================================================

# --- macOS system PATH ---
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# --- Homebrew (Apple Silicon) ---
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# --- asdf ---
if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

if [[ -d "$HOME/.asdf/shims" ]]; then
  export PATH="$HOME/.asdf/shims:$PATH"
fi

# --- User local ---
export PATH="$HOME/.local/bin:$PATH"

# --- VS Code CLI ---
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# --- Aliases ---
alias pn='pnpm'

# --- History ---
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- Completion ---
autoload -Uz compinit
compinit

# --- Prompt ---
autoload -Uz colors && colors
PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%1~%f %# '
