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

# shellcheck source=scripts/doctor.d/000_common.sh
source "$DOCTOR_DIR/000_common.sh"

for module_file in "$DOCTOR_DIR"/*.sh; do
  [ -f "$module_file" ] || continue

  # 000_common.sh は最初に読み込んでいるのでスキップ
  [ "$(basename "$module_file")" = "000_common.sh" ] && continue

  source "$module_file"

  module_name="$(basename "$module_file" .sh)"

  # 先頭の数字とアンダースコアを除去
  module_name="${module_name#*_}"

  if declare -f "check_${module_name}" >/dev/null; then
    "check_${module_name}"
  else
    fail "check_${module_name}() not found"
  fi
done

print_summary

if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
