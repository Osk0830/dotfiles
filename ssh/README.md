# SSH

## このディレクトリの目的

SSH設定のテンプレートと、鍵作成手順を管理します。

## 絶対にGit管理しないもの

以下は絶対にコミットしません。

- 秘密鍵: `id_ed25519`
- 秘密鍵: `id_rsa`
- GitHubのトークン
- サーバーの本番接続情報
- パスワード

## Git管理してよいもの

- `config.example`
- `generate-key.md`
- `known-hosts.md`
- 接続先を伏せたサンプル
