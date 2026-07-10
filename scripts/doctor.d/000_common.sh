#!/usr/bin/env bash

green="\033[1;32m"
yellow="\033[1;33m"
red="\033[1;31m"
cyan="\033[1;36m"
blue="\033[1;34m"
reset="\033[0m"

pass_count=0
info_count=0
warn_count=0
fail_count=0

section() {
  printf "\n${cyan}== %s ==${reset}\n" "$1"
}

pass() {
  printf "${green}✔${reset} %s\n" "$1"
  pass_count=$((pass_count + 1))
}

info() {
  printf "${blue}ℹ${reset} %s\n" "$1"
  info_count=$((info_count + 1))
}

warn() {
  printf "${yellow}⚠${reset} %s\n" "$1"
  warn_count=$((warn_count + 1))
}

fail() {
  printf "${red}✘${reset} %s\n" "$1"
  fail_count=$((fail_count + 1))
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

first_line() {
  "$@" 2>/dev/null | head -n 1 || true
}

show_required_command() {
  local cmd="$1"

  if exists "$cmd"; then
    pass "$cmd: $(command -v "$cmd")"
  else
    fail "$cmd: not found"
  fi
}

show_optional_command() {
  local cmd="$1"

  if exists "$cmd"; then
    pass "$cmd: $(command -v "$cmd")"
  else
    warn "$cmd: not found"
  fi
}

check_file_sync() {
  local repo_file="$1"
  local home_file="$2"
  local label="$3"

  if [ ! -f "$repo_file" ]; then
    warn "$label repository file missing: ${repo_file#"$DOTFILES_DIR/"}"
    return
  fi

  if [ ! -f "$home_file" ]; then
    warn "$label home file missing: $home_file"
    return
  fi

  if [ "$repo_file" -ef "$home_file" ] 2>/dev/null; then
    pass "$label is linked to the repository"
  elif cmp -s "$repo_file" "$home_file"; then
    pass "$label matches the repository copy"
  else
    warn "$label differs from the repository copy"
  fi
}

print_summary() {
  section "Summary"
  echo "PASS: $pass_count"
  echo "INFO: $info_count"
  echo "WARN: $warn_count"
  echo "FAIL: $fail_count"
}
