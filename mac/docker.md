# Docker Desktop

## 管理方針

Docker Desktop本体はHomebrew Caskでは管理しません。

`Brewfile` から次の項目を除外します。

```ruby
brew "docker"
brew "docker-compose"
cask "docker"
```

Docker Desktopには通常、以下が含まれます。

- Docker Desktopアプリ
- `docker` CLI
- Docker Engine
- `docker compose` プラグイン
- Docker Context

CLIだけをHomebrewで別途入れると、Docker Desktop側のCLIやComposeと競合し、
パス・バージョン・アンインストール時の挙動が分かりにくくなるため、
このdotfilesではDocker関連を一括してDocker Desktopに任せます。

## インストール

1. Docker公式サイトからmacOS用Docker Desktopを入手する
2. `Docker.dmg` を開く
3. `Docker.app` を `/Applications` に移動する
4. Docker Desktopを起動する
5. 初回設定と権限付与を完了する
6. エンジンが起動するまで待つ
7. 新しいターミナルを開く

## 動作確認

```bash
docker --version
docker compose version
docker context show
docker info
docker run --rm hello-world
```

dotfiles全体の診断:

```bash
make doctor
```

または:

```bash
./scripts/doctor.sh
```

## Docker Desktopを入れたのに `docker` が見つからない場合

まずDocker Desktopを起動し、新しいターミナルを開きます。

```bash
open -a Docker
exec zsh
which docker
docker --version
```

Docker Desktopの設定画面にCLIツールのインストール・シンボリックリンクに
関する項目が表示される場合は、それを有効にします。

## `docker info` が失敗する場合

`docker --version` が成功しても、Docker Engineが動いていないと
`docker info` は失敗します。

確認:

```bash
docker context show
docker context ls
docker info
```

Docker Desktopを起動しているのに失敗する場合は、一度Macを再起動し、
Docker Desktopが完全に起動してから再確認します。

## Homebrewに古いDocker CLIが残っている場合

確認:

```bash
brew list --formula | grep -E '^(docker|docker-compose)$'
brew list --cask | grep '^docker$'
which -a docker
```

このdotfilesの方針へ揃える場合:

```bash
brew uninstall docker docker-compose
brew uninstall --cask docker
```

注意: `brew uninstall --cask docker` はDocker Desktopアプリを削除します。
すでに公式インストーラで再導入済みの場合は、状況を確認してから実行してください。

通常は先に次で状態を確認します。

```bash
brew list --formula | grep -E '^(docker|docker-compose)$' || true
brew list --cask | grep '^docker$' || true
ls -ld /Applications/Docker.app
which -a docker
```

## Brewfileを更新するときの注意

`brew bundle dump --force` を使うと、Docker Desktopをインストールしている環境では
`cask "docker"` が再びBrewfileへ書き込まれる可能性があります。

実行後は必ず確認します。

```bash
grep -nE 'docker|docker-compose' Brewfile
```

Docker関連の行が追加された場合は削除してからコミットします。
