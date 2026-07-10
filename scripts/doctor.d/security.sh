#!/usr/bin/env bash

check_security() {
  section "Security quick scan"

  if ! exists rg; then
    warn "rg not found; skipped secret scan"
    return
  fi

  local secret_scan_file
  secret_scan_file="$(mktemp)"

  if rg -n \
    "BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY|ghp_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}" \
    "$DOTFILES_DIR" \
    --glob '!docs/security.md' \
    --glob '!scripts/doctor.sh' \
    --glob '!scripts/doctor.d/security.sh' \
    >"$secret_scan_file" 2>/dev/null
  then
    warn "Potential secret-like strings found"
    cat "$secret_scan_file"
  else
    pass "No high-signal secret-like strings found"
  fi

  rm -f "$secret_scan_file"
}
