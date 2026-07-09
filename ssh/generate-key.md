# SSH Key Generation

## GitHub用SSH鍵を作る

```bash
ssh-keygen -t ed25519 -C "oshiro.sk.0830@gmail.com"
```

保存先は通常これでOK。

```text
~/.ssh/id_ed25519
```

## ssh-agentへ追加

```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

古いmacOSで `--apple-use-keychain` が使えない場合:

```bash
ssh-add -K ~/.ssh/id_ed25519
```

## 公開鍵をコピー

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

## GitHubに登録

GitHub → Settings → SSH and GPG keys → New SSH key

## 接続確認

```bash
ssh -T git@github.com
```

成功例:

```text
Hi Osk0830! You've successfully authenticated, but GitHub does not provide shell access.
```
