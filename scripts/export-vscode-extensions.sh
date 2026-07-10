#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

code --list-extensions | sort > "$ROOT_DIR/vscode/extensions.txt"

echo "Updated vscode/extensions.txt"
