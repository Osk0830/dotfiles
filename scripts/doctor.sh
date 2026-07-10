#!/usr/bin/env bash

set -uo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly DOTFILES_DIR
DOCTOR_DIR="$DOTFILES_DIR/scripts/doctor.d"
readonly DOCTOR_DIR

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
      # Used by dynamically sourced doctor modules.
      # shellcheck disable=SC2034
      STRICT=true
      ;;
    --network)
      # Used by dynamically sourced doctor modules.
      # shellcheck disable=SC2034
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

seen_module_names=""

while IFS= read -r module_file; do
  module_base="$(basename "$module_file")"

  # 000_common.sh は最初に読み込んでいるのでスキップ
  [ "$module_base" = "000_common.sh" ] && continue

  if [[ ! "$module_base" =~ ^[0-9]{3}_[a-z][a-z0-9_]*\.sh$ ]]; then
    fail "invalid doctor module name: $module_base"
    continue
  fi

  # 先頭の数字とアンダースコアを除去
  module_name="${module_base%.sh}"
  module_name="${module_name#*_}"
  check_func="check_${module_name}"

  if [[ " $seen_module_names " == *" $module_name "* ]]; then
    fail "duplicate doctor module name: $module_name"
    continue
  fi
  seen_module_names="${seen_module_names:+$seen_module_names }$module_name"

  unset -f "$check_func" 2>/dev/null || true
  # shellcheck source=/dev/null
  source "$module_file"

  if declare -f "$check_func" >/dev/null; then
    "$check_func"
  else
    fail "$check_func() not found"
  fi
done < <(find "$DOCTOR_DIR" -maxdepth 1 -type f -name '*.sh' -print | LC_ALL=C sort)

print_summary

if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
