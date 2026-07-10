#!/usr/bin/env bash

check_vscode() {
  section "VS Code"

  local vscode_user_dir="$HOME/Library/Application Support/Code/User"

  if [ -d "$vscode_user_dir" ]; then
    pass "VS Code user directory exists"
  else
    warn "VS Code user directory missing"
  fi

  local file
  for file in settings.json keybindings.json; do
    if [ -f "$vscode_user_dir/$file" ]; then
      pass "VS Code $file exists"
    else
      warn "VS Code $file missing"
    fi
  done

  if ! exists code; then
    warn "VS Code CLI is unavailable"
    return
  fi

  local installed_extensions_file
  local required_extensions_file
  local missing_extensions
  local extension_count

  installed_extensions_file="$(mktemp)"
  code --list-extensions 2>/dev/null \
    | tr '[:upper:]' '[:lower:]' \
    | sort -u > "$installed_extensions_file"

  extension_count="$(wc -l < "$installed_extensions_file" | tr -d ' ')"
  info "VS Code extensions installed: $extension_count"

  if [ ! -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
    info "vscode/extensions.txt not found; extension comparison skipped"
    rm -f "$installed_extensions_file"
    return
  fi

  required_extensions_file="$(mktemp)"
  grep -Ev '^[[:space:]]*(#|$)' "$DOTFILES_DIR/vscode/extensions.txt" \
    | tr '[:upper:]' '[:lower:]' \
    | sort -u > "$required_extensions_file"

  missing_extensions="$(
    comm -23 "$required_extensions_file" "$installed_extensions_file" || true
  )"

  if [ -z "$missing_extensions" ]; then
    pass "Required VS Code extensions are installed"
  else
    warn "Required VS Code extensions are missing"
    printf "%s\n" "$missing_extensions" | sed 's/^/  - /'
  fi

  rm -f "$installed_extensions_file" "$required_extensions_file"
}
