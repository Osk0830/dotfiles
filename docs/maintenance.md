# Maintenance

## Update Brewfile

```bash
brew bundle dump --force
```

## Update VS Code extensions

```bash
./scripts/export-vscode-extensions.sh
```

## Apply changes

```bash
git status
git add .
git commit -m "Update dotfiles"
git push
```

## Check shell config

```bash
zsh -n .zshrc
zsh -n .zprofile
```

## Check scripts

```bash
bash -n install.sh
bash -n scripts/*.sh
```
