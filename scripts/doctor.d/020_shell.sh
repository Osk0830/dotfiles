#!/usr/bin/env bash

check_shell() {
  section "Shell files"

  local file
  for file in \
    "$HOME/.zshrc" \
    "$HOME/.zprofile" \
    "$HOME/.gitconfig" \
    "$HOME/.gitignore_global" \
    "$HOME/.tool-versions"
  do
    if [ -f "$file" ]; then
      pass "exists: $file"
    else
      warn "missing: $file"
    fi
  done

  for file in "$HOME/.zshrc" "$HOME/.zprofile"; do
    if [ -f "$file" ]; then
      if zsh -n "$file"; then
        pass "$(basename "$file") syntax OK"
      else
        fail "$(basename "$file") syntax error"
      fi
    fi
  done

  section "Dotfile synchronization"
  check_file_sync "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" ".zshrc"
  check_file_sync "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile" ".zprofile"
  check_file_sync "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig" ".gitconfig"
  check_file_sync "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global" ".gitignore_global"
  check_file_sync "$DOTFILES_DIR/.tool-versions" "$HOME/.tool-versions" ".tool-versions"
}
