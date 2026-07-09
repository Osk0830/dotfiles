#!/usr/bin/env bash
set -e

brew bundle

cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .tool-versions ~/.tool-versions

source ~/.zshrc

echo "Done."
