#!/usr/bin/env bash

check_ssh() {
  section "SSH"

  local ssh_key_found=false
  local key

  for key in "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_rsa"; do
    if [ -f "$key" ]; then
      pass "SSH private key exists: $key"
      ssh_key_found=true
    fi
  done

  if [ "$ssh_key_found" = false ]; then
    warn "No standard SSH private key found"
    echo "  see: $DOTFILES_DIR/ssh/generate-key.md"
  fi

  if [ "$NETWORK" = false ]; then
    info "GitHub SSH connectivity check skipped; use --network"
    return
  fi

  local ssh_output
  ssh_output="$(ssh -o BatchMode=yes -o ConnectTimeout=8 -T git@github.com 2>&1 || true)"

  if printf "%s" "$ssh_output" | grep -qi "successfully authenticated"; then
    pass "GitHub SSH authentication succeeded"
  else
    warn "GitHub SSH authentication could not be confirmed"
    printf "  %s\n" "$(printf "%s" "$ssh_output" | head -n 1)"
  fi
}
