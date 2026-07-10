#!/usr/bin/env bash

set -uo pipefail

readonly DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly DOCTOR_DIR="$DOTFILES_DIR/scripts/doctor.d"

STRICT=false
NETWORK=false

usage() {
  cat <<'EOF'
Usage: ./scripts/doctor.sh [--strict] [--network]

Options:
  --strict   Treat an uncommitted working tree as a warning.
  --network  Run network-dependent checks such as GitHub SSH connectivity.
  -h         Show this help.
EOF
}

for arg in "$@"; do
  case "$arg" in
    --strict)
      STRICT=true
      ;;
    --network)
      NETWORK=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [ ! -d "$DOCTOR_DIR" ]; then
  echo "Doctor module directory not found: $DOCTOR_DIR" >&2
  exit 1
fi

# shellcheck source=scripts/doctor.d/common.sh
source "$DOCTOR_DIR/common.sh"

modules=(
  repository
  shell
  commands
  git
  asdf
  github
  ssh
  docker
  vscode
  homebrew
  documentation
  security
)

for module in "${modules[@]}"; do
  module_file="$DOCTOR_DIR/$module.sh"

  if [ ! -f "$module_file" ]; then
    fail "doctor module missing: $module_file"
    continue
  fi

  # shellcheck source=/dev/null
  source "$module_file"
  "check_$module"
done

print_summary

if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
