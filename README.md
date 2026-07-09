# dotfiles

> Mac開発環境を再現するための設定ファイル・手順書リポジトリ

このリポジトリは、`.zshrc` や VS Code 設定を置くだけではなく、
新しいMacや復旧時に **30〜60分で開発環境を戻す** ための手順書として使います。

---

## 目的

- Mac開発環境をGitで管理する
- 新しいMacでも同じ環境を短時間で復元する
- VS Code、Git、asdf、Python、Node、Dockerなどの設定を再現する
- 設定変更の履歴を残す
- うっかり秘密情報を混ぜない

---

## 管理しているもの

```text
dotfiles/
├── .zshrc
├── .zprofile
├── .gitconfig
├── .gitignore_global
├── .tool-versions
├── Brewfile
├── install.sh
│
├── vscode/
│   ├── settings.json
│   ├── keybindings.json
│   ├── extensions.txt
│   ├── profiles.md
│   └── recommended-extensions.md
│
├── github/
│   ├── README.md
│   ├── auth.md
│   ├── aliases.md
│   ├── commands.md
│   └── workflow.md
│
├── ssh/
│   ├── README.md
│   ├── config.example
│   ├── generate-key.md
│   └── known-hosts.md
│
├── mac/
│   ├── README.md
│   ├── setup.md
│   ├── homebrew.md
│   ├── asdf.md
│   ├── defaults.md
│   ├── finder.md
│   ├── dock.md
│   └── keyboard.md
│
├── scripts/
└── docs/
```

---

## まず読むもの

初回セットアップ時:

1. [docs/first-setup.md](docs/first-setup.md)
2. [mac/setup.md](mac/setup.md)
3. [ssh/generate-key.md](ssh/generate-key.md)
4. [github/auth.md](github/auth.md)

普段の更新時:

1. [docs/how-to-update.md](docs/how-to-update.md)
2. [docs/maintenance.md](docs/maintenance.md)

復旧時:

1. [docs/restore.md](docs/restore.md)

---

## 初回セットアップの流れ

```text
1. Command Line Tools
2. Homebrew
3. GitHub CLI
4. SSH
5. dotfiles clone
6. Brewfile
7. asdf
8. Node / Python
9. VS Code
10. Docker //Docker Desktop は Homebrew Cask 管理せず、公式インストーラまたは既存アプリを使用する。
11. 動作確認
```

詳しくは [docs/first-setup.md](docs/first-setup.md) を参照してください。

---

## インストール

```bash
git clone git@github.com:Osk0830/dotfiles.git
cd dotfiles
chmod +x install.sh scripts/*.sh
./install.sh
```

手動で進める場合:

```bash
brew bundle

cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .tool-versions ~/.tool-versions

source ~/.zshrc
asdf install
```

---

## VS Code設定を反映する

```bash
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
./scripts/install-vscode-extensions.sh
```

---

## 現在のVS Code拡張を保存する

```bash
./scripts/export-vscode-extensions.sh
```

または:

```bash
code --list-extensions | sort > vscode/extensions.txt
```

---

## ローカルで設定を変えたらどうする？

例: VS Codeの設定を変更した場合

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" vscode/settings.json
git status
git add vscode/settings.json
git commit -m "Update VS Code settings"
git push
```

例: VS Codeの拡張を追加した場合

```bash
./scripts/export-vscode-extensions.sh
git add vscode/extensions.txt
git commit -m "Update VS Code extensions"
git push
```

例: Homebrewでアプリを追加した場合

```bash
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile"
git push
```

詳しくは [docs/how-to-update.md](docs/how-to-update.md) を参照してください。

---

## 絶対にコミットしないもの

- SSH秘密鍵
- APIキー
- GitHub token
- `.env`
- 本番サーバー情報
- 案件固有の認証情報
- VS Codeの案件固有 `autoApprove` 設定

---

## このリポジトリの考え方

このリポジトリは完成品ではなく、使いながら育てます。

```text
設定変更
  ↓
動作確認
  ↓
dotfilesへ反映
  ↓
commit
  ↓
push
```

数か月後・数年後の自分が、同じ環境をすぐ再現できることを目指します。
