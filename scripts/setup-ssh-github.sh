#!/usr/bin/env bash
set -euo pipefail

EMAIL="${1:-oshiro.sk.0830@gmail.com}"
KEY_PATH="$HOME/.ssh/id_ed25519"

if [ -f "$KEY_PATH" ]; then
  echo "SSH key already exists: $KEY_PATH"
else
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH"
fi

eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$KEY_PATH" || ssh-add -K "$KEY_PATH"

echo "Public key:"
cat "$KEY_PATH.pub"

echo ""
echo "Copy public key:"
echo "pbcopy < $KEY_PATH.pub"
