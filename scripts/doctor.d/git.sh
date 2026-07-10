#!/usr/bin/env bash

check_git() {
  section "Git"

  local git_name
  local git_email

  git_name="$(git config --global user.name 2>/dev/null || true)"
  git_email="$(git config --global user.email 2>/dev/null || true)"

  if [ -n "$git_name" ]; then
    pass "user.name: $git_name"
  else
    warn "global Git user.name is not set"
  fi

  if [ -n "$git_email" ]; then
    pass "user.email: $git_email"
  else
    warn "global Git user.email is not set"
  fi
}
