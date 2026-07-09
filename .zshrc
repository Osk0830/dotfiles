# ==================================================
# ~/.zshrc
# ==================================================
# 開発用シェル設定
# PATH の優先順:
# 1. Homebrew
# 2. macOS 標準
# 3. asdf shims
# 4. ユーザーローカル
# 5. VS Code CLI
# ==================================================

# macOS 標準 PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# Homebrew (Apple Silicon)
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# asdf 本体
if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# asdf shims
export PATH="$HOME/.asdf/shims:$PATH"

# ユーザーローカル
export PATH="$HOME/.local/bin:$PATH"

# VS Code の code コマンド
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# エイリアス
alias pn='pnpm'

# 履歴設定
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# 補完
autoload -Uz compinit
compinit

# プロンプト
autoload -Uz colors && colors
PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%1~%f %# '
