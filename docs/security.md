# Security

## 絶対にコミットしないもの

- SSH秘密鍵
- APIキー
- GitHub token
- `.env`
- 本番DB接続情報
- 本番サーバー情報
- パスワード
- Cookie
- 認証済み設定ファイル
- 案件固有の内部URL
- 顧客名や社名が含まれる機密情報

---

## SSH

コミットしてよい:

- `ssh/config.example`
- `ssh/generate-key.md`
- `ssh/README.md`

コミットしない:

- `~/.ssh/id_ed25519`
- `~/.ssh/id_rsa`
- `~/.ssh/config` の実案件情報
- `known_hosts` に機密性のある接続先がある場合

---

## GitHub CLI

コミットしてよい:

- `github/auth.md`
- `github/commands.md`
- `github/aliases.md`

コミットしない:

- `~/.config/gh/hosts.yml`
- GitHub token
- 認証済み設定

---

## VS Code

コミット注意:

- `settings.json`

特に以下は案件固有情報やパスを含みやすいため注意します。

- `chat.tools.terminal.autoApprove`
- `terminal.integrated.env.*`
- `php.validate.executablePath`
- ワークスペース固有パス

---

## チェックコマンド

コミット前に確認:

```bash
git diff
git status
```

秘密情報っぽい文字列を探す:

```bash
rg -n "token|secret|password|passwd|apikey|api_key|BEGIN .*PRIVATE KEY" .
```

---

## 万が一コミットしたら

1. すぐpushを止める
2. そのファイルを削除
3. 履歴から削除が必要か判断
4. tokenや鍵は再発行
5. GitHubにpush済みなら、秘密情報は漏れた前提で対応
