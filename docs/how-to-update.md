# ローカルで設定変更した時の反映手順

## 基本方針

ローカル環境で設定を変更したら、dotfilesへ戻してGit管理します。

```text
ローカル設定を変更
  ↓
問題ないか確認
  ↓
dotfilesへコピー
  ↓
git diffで確認
  ↓
commit
  ↓
push
```

---

## VS Code settings.jsonを変更した場合

VS Codeで設定変更後:

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" vscode/settings.json
```

確認:

```bash
git diff vscode/settings.json
```

コミット:

```bash
git add vscode/settings.json
git commit -m "Update VS Code settings"
git push
```

---

## VS Code keybindings.jsonを変更した場合

```bash
cp "$HOME/Library/Application Support/Code/User/keybindings.json" vscode/keybindings.json
git diff vscode/keybindings.json
git add vscode/keybindings.json
git commit -m "Update VS Code keybindings"
git push
```

---

## VS Code拡張機能を追加・削除した場合

```bash
./scripts/export-vscode-extensions.sh
git diff vscode/extensions.txt
git add vscode/extensions.txt
git commit -m "Update VS Code extensions"
git push
```

または直接:

```bash
code --list-extensions | sort > vscode/extensions.txt
```

---

## HomebrewでアプリやCLIを追加した場合

例:

```bash
brew install jq
```

Brewfileを更新:

```bash
brew bundle dump --force
```

確認:

```bash
git diff Brewfile
```

コミット:

```bash
git add Brewfile
git commit -m "Update Brewfile"
git push
```

---

## .zshrc を変更した場合

現在の `~/.zshrc` をdotfilesへ反映:

```bash
cp ~/.zshrc .zshrc
zsh -n .zshrc
git diff .zshrc
git add .zshrc
git commit -m "Update zshrc"
git push
```

反映前に構文チェックします。

```bash
zsh -n .zshrc
```

---

## .gitconfig を変更した場合

```bash
cp ~/.gitconfig .gitconfig
git diff .gitconfig
git add .gitconfig
git commit -m "Update gitconfig"
git push
```

確認:

```bash
git config --global -l
```

---

## asdfのグローバルバージョンを変更した場合

例:

```bash
asdf set -u python 3.12.8
```

ホームの `.tool-versions` をdotfilesへ反映:

```bash
cp ~/.tool-versions .tool-versions
git diff .tool-versions
git add .tool-versions
git commit -m "Update global tool versions"
git push
```

---

## SSH設定を変更した場合

`~/.ssh/config` をそのままコミットしない方が安全です。

公開して問題ない形にして `ssh/config.example` へ反映します。

```bash
cp ~/.ssh/config ssh/config.local.tmp
```

その後、以下を削除・匿名化して `ssh/config.example` に反映します。

- 本番ホスト名
- 案件名
- 社名
- IPアドレス
- 秘密鍵パス
- ユーザー名が機密の場合

---

## GitHub CLI aliasを追加した場合

```bash
gh alias list > github/aliases.export.txt
```

ただし、案件固有aliasが入っていないか確認してからコミットします。

または `github/aliases.md` に手動で追記します。

---

## コミット前チェック

```bash
git status
git diff
```

スクリプト構文チェック:

```bash
zsh -n .zshrc
zsh -n .zprofile
bash -n install.sh
bash -n scripts/*.sh
```

---

## コミットメッセージ例

```bash
git commit -m "Update VS Code settings"
git commit -m "Update Brewfile"
git commit -m "Add SSH setup docs"
git commit -m "Update global tool versions"
```
