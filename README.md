# dotfiles

Personal development environment for macOS.

## Contents

- `.zshrc`
- `.zprofile`
- `.gitconfig`
- `.gitignore_global`
- `.tool-versions`
- `Brewfile`
- `vscode/`
- `github/`
- `ssh/`
- `mac/`
- `scripts/`
- `docs/`

## First setup

```bash
git clone git@github.com:Osk0830/dotfiles.git
cd dotfiles
chmod +x install.sh scripts/*.sh
./install.sh
```

## Manual setup

```bash
brew bundle
cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .tool-versions ~/.tool-versions
source ~/.zshrc
```

## VS Code

Apply settings:

```bash
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
```

Install extensions:

```bash
./scripts/install-vscode-extensions.sh
```

Export current extensions:

```bash
./scripts/export-vscode-extensions.sh
```

## GitHub CLI

Authenticate:

```bash
gh auth login
```

Setup aliases:

```bash
./scripts/setup-gh-aliases.sh
```

## SSH

Read:

- `ssh/generate-key.md`
- `ssh/config.example`

Never commit private keys.
