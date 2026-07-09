# Homebrew

## インストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Apple Silicon:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Brewfileを作る

現在の環境を出力:

```bash
brew bundle dump --force
```

## Brewfileから復元

```bash
brew bundle
```

## 確認

```bash
brew doctor
brew update
brew outdated
```
