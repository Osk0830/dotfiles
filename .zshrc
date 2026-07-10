# ==================================================
# ~/.zshrc
# ==================================================
# Development Environment
#
# Priority
# 1. macOS System
# 2. Homebrew
# 3. asdf
# 4. User Local
# 5. VSCode
# ==================================================

##############################
# macOS
##############################

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

##############################
# Homebrew (Apple Silicon)
##############################

if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

##############################
# asdf
##############################

if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# asdf shims
export PATH="$HOME/.asdf/shims:$PATH"

##############################
# User Local
##############################

export PATH="$HOME/.local/bin:$PATH"

##############################
# VS Code
##############################

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

##############################
# Aliases
##############################

alias pn='pnpm'

##############################
# History
##############################

HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

##############################
# Completion
##############################

autoload -Uz compinit
compinit

##############################
# Prompt
##############################

autoload -Uz colors && colors

PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%1~%f %# '
