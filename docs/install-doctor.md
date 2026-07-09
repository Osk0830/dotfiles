# install.sh / doctor.sh

## install.sh

大城さんの現在の環境に合わせたインストールスクリプトです。

前提:

- macOS
- Homebrew
- asdf
- Node.js 22.15.0
- Python 3.12.8
- VS Code
- Docker
- GitHub CLI

実行:

```bash
chmod +x install.sh scripts/*.sh
./install.sh
```

## doctor.sh

環境診断スクリプトです。

```bash
./scripts/doctor.sh
```

確認するもの:

- Git
- Homebrew
- GitHub CLI
- asdf
- Node
- Python
- pip
- Docker
- VS Code
- MkDocs
- SSH key
- VS Code設定
- Brewfile
- 秘密情報らしき文字列

## Makefile

```bash
make install
make doctor
make check
make vscode-install
make vscode-export
make aliases
make defaults
```

## 注意

`install.sh` は既存ファイルを上書きする前にバックアップを作ります。

例:

```text
~/.zshrc.backup.20260709120000
```
