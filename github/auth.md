# GitHub CLI Authentication

## インストール確認

```bash
gh --version
```

## ログイン

```bash
gh auth login
```

おすすめ選択:

```text
GitHub.com
HTTPS or SSH: SSH
Authenticate Git with GitHub CLI: Yes
Login with a web browser
```

## 状態確認

```bash
gh auth status
```

## ログアウト

```bash
gh auth logout
```

## 注意

GitHub tokenは絶対にGit管理しません。

`~/.config/gh/hosts.yml` には認証情報が含まれるため、dotfilesには入れません。
