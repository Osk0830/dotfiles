# dotfiles Roadmap

## Phase 1 ⭐⭐⭐⭐⭐ install.sh 強化
目的: `./install.sh` だけで環境構築を完了できるようにする。

### 実装予定
- Homebrew確認
- Brewfile実行
- dotfiles配置
- asdf install
- VS Code拡張
- GitHub CLI alias
- macOS defaults
- doctor実行

関連ファイル:
- install.sh
- scripts/install-vscode-extensions.sh
- scripts/setup-gh-aliases.sh
- scripts/mac-defaults.sh
- scripts/doctor.sh（追加予定）

---

## Phase 2 ⭐⭐⭐⭐⭐ doctor.sh

目的:
環境診断を1コマンドで行う。

```bash
./scripts/doctor.sh
```

チェック項目

- Git
- Homebrew
- gh
- SSH
- asdf
- Node
- Python
- Docker
- VS Code
- MkDocs

---

## Phase 3 ⭐⭐⭐⭐⭐ bootstrap.sh

新しいMacで最初に実行するスクリプト。

```bash
./scripts/bootstrap.sh
```

流れ

1. Homebrew
2. GitHub CLI
3. dotfiles clone
4. install.sh

---

## Phase 4 ⭐⭐⭐⭐⭐ Makefile

```bash
make install
make doctor
make vscode
make update
make brew
```

---

## Phase 5 ⭐⭐⭐⭐ VS Code snippets

```
vscode/snippets/
```

React / PHP / WordPress / TypeScript スニペット管理。

---

## Phase 6 ⭐⭐⭐⭐ Brewfile

開発ツール追加・整理。

---

## Phase 7 ⭐⭐⭐⭐ macOS defaults

Finder / Dock / Keyboard 等。

---

## Phase 8 ⭐⭐⭐⭐ GitHub CLI

Alias・Workflow・PR運用。

---

## Phase 9 ⭐⭐⭐ GitHub Actions

Shell / JSON / Markdown のLint。

---

## Phase 10 ⭐⭐⭐ Releases

v1.0
v1.1 ...
