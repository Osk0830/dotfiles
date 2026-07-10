#!/usr/bin/env bash

check_commands() {
  section "Core commands"

  local cmd
  for cmd in git brew asdf node python pip code mkdocs rg tree; do
    show_required_command "$cmd"
  done

  for cmd in gh jq pnpm; do
    show_optional_command "$cmd"
  done

  section "Versions"
  exists git && first_line git --version
  exists brew && first_line brew --version
  exists asdf && first_line asdf --version
  exists node && node --version || true
  exists python && python --version || true
  exists pip && first_line pip --version
  exists code && first_line code --version
  exists mkdocs && first_line mkdocs --version
  exists pnpm && pnpm --version || true
}
