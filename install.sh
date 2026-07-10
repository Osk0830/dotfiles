#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

green="\033[1;32m"
yellow="\033[1;33m"
cyan="\033[1;36m"
reset="\033[0m"

info() {
  printf "${cyan}== %s ==${reset}\n" "$1"
}

pass() {
  printf "${green}✔${reset} %s\n" "$1"
}

warn() {
  printf "${yellow}⚠${reset} %s\n" "$1"
}

copy_file() {
  local source_file="$1"
  local target_file="$2"

  if [ ! -f "$source_file" ]; then
    warn "Skipped missing file: $source_file"
    return
  fi

  if [ -f "$target_file" ] && ! cmp -s "$source_file" "$target_file"; then
    cp "$target_file" "${target_file}.backup.$(date +%Y%m%d%H%M%S)"
    warn "Backed up existing file: $target_file"
  fi

  cp "$source_file" "$target_file"
  pass "Installed: $target_file"
}

info "Homebrew packages"
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed."
  echo "Install Homebrew first, then run this script again."
  exit 1
fi

brew bundle --file "$DOTFILES_DIR/Brewfile"
pass "Brewfile dependencies installed"

info "Dotfiles"
copy_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
copy_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
copy_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
copy_file "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
copy_file "$DOTFILES_DIR/.tool-versions" "$HOME/.tool-versions"

info "Docker Desktop"
if [ -d "/Applications/Docker.app" ]; then
  pass "Docker Desktop application found"
else
  warn "Docker Desktop is not installed in /Applications"
  echo "Install it manually. See: $DOTFILES_DIR/mac/docker.md"
fi

if command -v docker >/dev/null 2>&1; then
  pass "docker CLI found: $(command -v docker)"
else
  warn "docker CLI is not available yet"
  echo "After installing and starting Docker Desktop, open a new terminal."
fi

info "Finish"
echo "Reload the shell:"
echo "  exec zsh"
echo
echo "Then run:"
echo "  make doctor"
