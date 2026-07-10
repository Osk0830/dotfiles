#!/usr/bin/env bash

check_asdf() {
  section "asdf"

  if ! exists asdf; then
    fail "asdf is unavailable"
    return
  fi

  asdf current || true

  local plugin
  for plugin in nodejs python; do
    if asdf plugin list 2>/dev/null | grep -qx "$plugin"; then
      pass "asdf plugin: $plugin"
    else
      warn "asdf plugin missing: $plugin"
    fi
  done

  if [ ! -f "$DOTFILES_DIR/.tool-versions" ]; then
    warn ".tool-versions is missing"
    return
  fi

  local tool expected_version actual_version
  while read -r tool expected_version _; do
    [ -z "${tool:-}" ] && continue

    case "$tool" in
      nodejs)
        actual_version="$(node --version 2>/dev/null | sed 's/^v//' || true)"
        ;;
      python)
        actual_version="$(python --version 2>/dev/null | awk '{print $2}' || true)"
        ;;
      *)
        continue
        ;;
    esac

    if [ "$actual_version" = "$expected_version" ]; then
      pass "$tool version matches .tool-versions: $expected_version"
    else
      warn "$tool version mismatch: expected $expected_version, got ${actual_version:-unknown}"
    fi
  done < "$DOTFILES_DIR/.tool-versions"
}
