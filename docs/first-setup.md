# First Setup

## 目的

新しいMacで開発環境を復元するための最短手順です。

---

## 1. Command Line Tools

```bash
xcode-select --install
```

---

## 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Apple Silicon:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

## 3. GitHub CLI

```bash
brew install gh
gh auth login
```

詳しくは `github/auth.md` を参照。

---

## 4. SSH

GitHub用の鍵を作成:

```bash
ssh-keygen -t ed25519 -C "oshiro.sk.0830@gmail.com"
```

公開鍵をコピー:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

GitHubに登録後:

```bash
ssh -T git@github.com
```

詳しくは `ssh/generate-key.md` を参照。

---

## 5. dotfilesをclone

```bash
git clone git@github.com:Osk0830/dotfiles.git
cd dotfiles
```

---

## 6. Brewfile

```bash
brew bundle
```

---

## 7. 設定ファイル反映

```bash
cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .tool-versions ~/.tool-versions
source ~/.zshrc
```

---

## 8. asdf

```bash
asdf plugin add nodejs
asdf plugin add python
asdf install
```

確認:

```bash
node -v
python --version
pip --version
```

---

## 9. VS Code

```bash
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
./scripts/install-vscode-extensions.sh
```

---

## 10. 動作確認

```bash
git --version
gh --version
node -v
python --version
docker --version
code --version
```
