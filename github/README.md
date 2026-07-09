# GitHub CLI

## 目的

GitHub CLI (`gh`) を使うと、ターミナルからGitHub操作ができます。

このディレクトリでは、認証・alias・よく使う操作を管理します。

---

## 重要度

GitHub CLIはかなり重要です。

理由:

- ブラウザを開かずにPRを確認できる
- リポジトリcloneが楽
- PR checkoutが速い
- GitHub PagesやActionsの確認にも使える
- dotfiles復元時にも便利

---

## 初期設定

```bash
gh auth login
```

おすすめ選択:

```text
GitHub.com
SSH
Authenticate Git with GitHub CLI: Yes
Login with a web browser
```

確認:

```bash
gh auth status
```

---

## よく使うコマンド

```bash
gh repo clone Osk0830/debug-handbook
gh repo view --web
gh pr status
gh pr create --web
gh pr checkout <number>
gh issue list
```

---

## alias

おすすめalias:

```bash
gh alias set co "pr checkout"
gh alias set prs "pr status"
gh alias set pv "pr view"
gh alias set pc "pr create"
gh alias set pm "pr merge"
gh alias set rl "repo list"
```

まとめて設定:

```bash
./scripts/setup-gh-aliases.sh
```

---

## 管理しないもの

`~/.config/gh/hosts.yml` は認証情報を含むため、Git管理しません。
