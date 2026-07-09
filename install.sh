#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Homebrew packages..."
brew bundle --file "$DOTFILES_DIR/Brewfile"

echo "Copying dotfiles..."
cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
cp "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
cp "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
cp "$DOTFILES_DIR/.tool-versions" "$HOME/.tool-versions"

echo "Installing VS Code extensions..."
if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
  grep -v '^#' "$DOTFILES_DIR/vscode/extensions.txt" | grep -v '^$' | xargs -n 1 code --install-extension
else
  echo "Skipped VS Code extensions. code command or extensions.txt not found."
fi

echo "Done."
echo "Run: source ~/.zshrc"
