#!/usr/bin/env bash

check_github() {
  section "GitHub CLI"

  if ! exists gh; then
    warn "GitHub CLI is unavailable"
    return
  fi

  if gh auth status >/dev/null 2>&1; then
    pass "GitHub CLI authenticated"
  else
    warn "GitHub CLI is installed but not authenticated"
    echo "  fix: gh auth login"
  fi
}
