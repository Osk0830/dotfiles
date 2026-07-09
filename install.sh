#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

log() {
  printf "\n\033[1;36m==> %s\033[0m\n" "$1"
}

warn() {
  printf "\033[1;33m[WARN]\033[0m %s\n" "$1"
}

ok() {
  printf "\033[1;32m[OK]\033[0m %s\n" "$1"
}

confirm() {
  local message="$1"
  read -r -p "$message [y/N]: " answer
  case "$answer" in
    [yY][eE][sS]|[yY]) return 0 ;;
    *) return 1 ;;
  esac
}

backup_if_exists() {
  local target="$1"

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    cp -R "$target" "$backup"
    warn "Backed up $target -> $backup"
  fi
}

copy_file() {
  local src="$1"
  local dest="$2"

  if [ ! -f "$src" ]; then
    warn "Skipped. Source not found: $src"
    return
  fi

  mkdir -p "$(dirname "$dest")"
  backup_if_exists "$dest"
  cp "$src" "$dest"
  ok "Copied $src -> $dest"
}

log "dotfiles install started"

if ! command -v brew >/dev/null 2>&1; then
  warn "Homebrew is not installed."
  if confirm "Install Homebrew now?"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    warn "Skipped Homebrew installation."
  fi
else
  ok "Homebrew found: $(brew --version | head -n1)"
fi

if command -v brew >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  log "Running brew bundle"
  brew bundle --file "$DOTFILES_DIR/Brewfile"
else
  warn "Skipped brew bundle."
fi

log "Copying dotfiles"

copy_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
copy_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
copy_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
copy_file "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
copy_file "$DOTFILES_DIR/.tool-versions" "$HOME/.tool-versions"

log "Checking asdf"

if command -v asdf >/dev/null 2>&1; then
  ok "asdf found"

  if ! asdf plugin list | grep -qx "nodejs"; then
    log "Adding asdf nodejs plugin"
    asdf plugin add nodejs || true
  fi

  if ! asdf plugin list | grep -qx "python"; then
    log "Adding asdf python plugin"
    asdf plugin add python || true
  fi

  if [ -f "$HOME/.tool-versions" ]; then
    log "Installing asdf tools from ~/.tool-versions"
    asdf install
  fi

  log "Reshim asdf"
  asdf reshim || true
else
  warn "asdf not found. Check Homebrew/asdf installation."
fi

log "VS Code settings"

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if [ -d "$VSCODE_USER_DIR" ]; then
  if [ -f "$DOTFILES_DIR/vscode/settings.json" ]; then
    copy_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
  fi

  if [ -f "$DOTFILES_DIR/vscode/keybindings.json" ]; then
    copy_file "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
  fi
else
  warn "VS Code user settings directory not found: $VSCODE_USER_DIR"
fi

if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
  log "Installing VS Code extensions"
  grep -v '^#' "$DOTFILES_DIR/vscode/extensions.txt" | grep -v '^$' | xargs -n 1 code --install-extension
else
  warn "Skipped VS Code extensions. code command or extensions.txt not found."
fi

if command -v gh >/dev/null 2>&1; then
  log "GitHub CLI status"
  gh auth status || warn "gh is installed but not authenticated. Run: gh auth login"

  if [ -x "$DOTFILES_DIR/scripts/setup-gh-aliases.sh" ]; then
    if confirm "Setup GitHub CLI aliases?"; then
      "$DOTFILES_DIR/scripts/setup-gh-aliases.sh"
    fi
  fi
else
  warn "GitHub CLI not found."
fi

if [ -x "$DOTFILES_DIR/scripts/mac-defaults.sh" ]; then
  if confirm "Apply macOS defaults?"; then
    "$DOTFILES_DIR/scripts/mac-defaults.sh"
  else
    warn "Skipped macOS defaults."
  fi
fi

log "Running doctor"

if [ -x "$DOTFILES_DIR/scripts/doctor.sh" ]; then
  "$DOTFILES_DIR/scripts/doctor.sh" || true
else
  warn "doctor.sh not found or not executable."
fi

log "Install finished"
echo "Run: source ~/.zshrc"
