#!/usr/bin/env bash

check_documentation() {
  section "Documentation"

  local file
  for file in \
    "$DOTFILES_DIR/README.md" \
    "$DOTFILES_DIR/mac/docker.md" \
    "$DOTFILES_DIR/docs/first-setup.md" \
    "$DOTFILES_DIR/docs/how-to-update.md"
  do
    if [ -f "$file" ]; then
      pass "exists: ${file#"$DOTFILES_DIR/"}"
    else
      warn "missing: ${file#"$DOTFILES_DIR/"}"
    fi
  done
}
