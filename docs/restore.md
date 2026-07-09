# Restore

## dotfiles復元

```bash
git clone git@github.com:Osk0830/dotfiles.git
cd dotfiles
brew bundle
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .tool-versions ~/.tool-versions
source ~/.zshrc
asdf install
```

## VS Code復元

```bash
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
./scripts/install-vscode-extensions.sh
```
