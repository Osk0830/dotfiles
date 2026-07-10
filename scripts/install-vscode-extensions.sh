#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

while read -r extension; do
    [ -z "$extension" ] && continue
    code --install-extension "$extension"
done < "$ROOT_DIR/vscode/extensions.txt"
