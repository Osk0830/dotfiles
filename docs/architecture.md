# dotfiles Architecture

## 目的

このリポジトリは、Mac開発環境を再現するための設定ファイルと手順書を管理します。

単なるバックアップではなく、以下を目的にします。

- 新しいMacへの移行
- 開発環境の再現
- 設定変更の履歴管理
- セットアップ手順の標準化
- トラブル時の復旧

---

## ディレクトリの役割

|Path|役割|
|---|---|
|`.zshrc`|通常のzsh設定|
|`.zprofile`|ログインシェル用の最小設定|
|`.gitconfig`|Gitのグローバル設定|
|`.gitignore_global`|全プロジェクト共通のgitignore|
|`.tool-versions`|asdfのグローバルバージョン|
|`Brewfile`|Homebrewパッケージ一覧|
|`vscode/`|VS Code設定・拡張|
|`github/`|GitHub CLI手順|
|`ssh/`|SSH設定テンプレート|
|`mac/`|macOS初期設定|
|`scripts/`|セットアップ補助スクリプト|
|`docs/`|運用手順書|

---

## 基本設計

### 1. 秘密情報は入れない

秘密鍵・トークン・パスワード・案件固有情報は入れません。

### 2. 設定と手順を分ける

設定ファイルはルートや `vscode/` に置き、説明は `docs/` や各カテゴリのREADMEに置きます。

### 3. まず手動で安全に、徐々に自動化する

いきなり全部自動化せず、まずは手順として残します。

安全が確認できたものだけ `scripts/` にします。

### 4. ローカル変更は必ずdotfilesへ戻す

VS Code設定、拡張、Brewfile、zsh設定を変えたら、このリポジトリに反映します。

---

## 更新サイクル

```text
ローカルで設定変更
  ↓
動作確認
  ↓
dotfilesへコピー
  ↓
git diff
  ↓
commit
  ↓
push
```

---

## 将来的に追加したいもの

- VS Code snippets
- GitHub Actionsで簡易lint
- Mac初期設定スクリプトの強化
- Claude Code / ChatGPT関連の設定メモ
- PHP / Composer / phpbrew設定メモ
- Docker Desktop設定メモ
