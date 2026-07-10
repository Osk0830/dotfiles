#!/usr/bin/env bash

check_repository() {
  section "Repository"

  if [ ! -d "$DOTFILES_DIR/.git" ]; then
    fail "dotfiles is not a Git repository: $DOTFILES_DIR"
    return
  fi

  pass "dotfiles is a Git repository"

  local current_branch
  current_branch="$(git -C "$DOTFILES_DIR" branch --show-current 2>/dev/null || true)"
  [ -n "$current_branch" ] && info "branch: $current_branch"

  local remote_origin
  remote_origin="$(git -C "$DOTFILES_DIR" remote get-url origin 2>/dev/null || true)"
  if [ -n "$remote_origin" ]; then
    pass "origin: $remote_origin"
  else
    warn "origin remote is not configured"
  fi

  local status_output
  status_output="$(git -C "$DOTFILES_DIR" status --short 2>/dev/null || true)"

  if [ -n "$status_output" ]; then
    if [ "$STRICT" = true ]; then
      warn "working tree has changes"
    else
      info "working tree has changes"
    fi
    printf "%s\n" "$status_output"
  else
    pass "working tree clean"
  fi
}
