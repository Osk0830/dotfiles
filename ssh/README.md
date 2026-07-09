# SSH

## 目的

SSH鍵と接続設定の作成手順を管理します。

---

## SSHで管理するもの

Git管理してよい:

- `config.example`
- `generate-key.md`
- `known-hosts.md`
- 手順書

Git管理しない:

- 秘密鍵
- 本番サーバー情報
- 顧客名
- IPアドレス
- パスワード
- 認証済みconfig

---

## GitHub用SSH鍵

```bash
ssh-keygen -t ed25519 -C "oshiro.sk.0830@gmail.com"
```

公開鍵をコピー:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

接続確認:

```bash
ssh -T git@github.com
```

---

## config.example の使い方

```bash
cp ssh/config.example ~/.ssh/config
chmod 600 ~/.ssh/config
```

案件固有のサーバー情報は `~/.ssh/config` にだけ書き、Gitには入れません。
