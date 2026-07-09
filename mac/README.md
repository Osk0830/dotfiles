# Mac Setup

## 目的

Mac初期セットアップの手順を管理します。

---

## 重要度

Mac初期設定を手順化しておくと、以下が楽になります。

- Mac買い替え
- 初期化後の復旧
- 仕事用Mac追加
- 設定の見直し

---

## 推奨セットアップ順

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
11. MkDocs
12. 動作確認
```

---

## macOS defaults

`mac/defaults.md` と `scripts/mac-defaults.sh` に設定候補があります。

実行前に内容を確認してください。

```bash
./scripts/mac-defaults.sh
```
