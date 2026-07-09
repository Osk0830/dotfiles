# Mac Initial Setup

## 目的

新しいMacで、開発環境を短時間で復元するための手順です。

## 全体フロー

```text
1. macOS初期設定
2. Homebrew
3. Git
4. SSH
5. GitHub CLI
6. dotfiles clone
7. Brewfile
8. asdf
9. Node / Python
10. VS Code
11. Docker
12. MkDocs
```

## 1. Command Line Tools

```bash
xcode-select --install
```

## 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Apple Silicon:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## 3. dotfiles clone

```bash
gh repo clone Osk0830/dotfiles
```

またはSSH:

```bash
git clone git@github.com:Osk0830/dotfiles.git
```

## 4. Brewfile

```bash
cd dotfiles
brew bundle
```

## 5. 設定ファイル反映

```bash
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .tool-versions ~/.tool-versions
source ~/.zshrc
```

## 6. asdf

```bash
asdf plugin add nodejs
asdf plugin add python
asdf install
```

## 7. VS Code

```bash
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
./scripts/install-vscode-extensions.sh
```

## 8. 確認

```bash
node -v
python --version
git --version
docker --version
code --version
```
