#!/usr/bin/env bash

check_homebrew() {
  section "Homebrew"

  if ! exists brew || [ ! -f "$DOTFILES_DIR/Brewfile" ]; then
    warn "Homebrew or Brewfile is unavailable"
    return
  fi

  if brew bundle check --file "$DOTFILES_DIR/Brewfile" >/dev/null 2>&1; then
    pass "Brewfile dependencies satisfied"
  else
    warn "Brewfile dependencies are not fully satisfied"
    echo "  fix: brew bundle --file \"$DOTFILES_DIR/Brewfile\""
  fi

  if grep -Eq \
    '^[[:space:]]*(brew[[:space:]]+"docker"|brew[[:space:]]+"docker-compose"|cask[[:space:]]+"docker")[[:space:]]*$' \
    "$DOTFILES_DIR/Brewfile"
  then
    fail "Docker is still managed in Brewfile"
    echo '  remove: brew "docker", brew "docker-compose", cask "docker"'
  else
    pass "Docker Desktop is excluded from Brewfile"
  fi

  local brew_doctor_file
  brew_doctor_file="$(mktemp)"

  if brew doctor >"$brew_doctor_file" 2>&1; then
    pass "brew doctor reports no problems"
  else
    warn "brew doctor reported findings"
    sed -n '1,12p' "$brew_doctor_file" | sed 's/^/  /'
    info "Run 'brew doctor' for the complete report"
  fi

  rm -f "$brew_doctor_file"

  local cleanup_output
  cleanup_output="$(brew bundle cleanup --file "$DOTFILES_DIR/Brewfile" --dry-run 2>&1 || true)"

  if printf "%s" "$cleanup_output" | grep -Eq 'Would uninstall|Would remove'; then
    info "Homebrew packages not listed in Brewfile were found"
    printf "%s\n" "$cleanup_output" | sed -n '1,12p' | sed 's/^/  /'
  else
    pass "No Brewfile cleanup candidates found"
  fi
}
