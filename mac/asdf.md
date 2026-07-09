# asdf

## 目的

Node.js / Python / Java などの言語バージョンを管理します。

## プラグイン

```bash
asdf plugin add nodejs
asdf plugin add python
```

必要なら:

```bash
asdf plugin add java
```

## インストール

`.tool-versions` がある場合:

```bash
asdf install
```

## グローバル設定

```bash
asdf set -u nodejs 22.15.0
asdf set -u python 3.12.8
```

## 確認

```bash
asdf current
node -v
python --version
pip --version
```

## プロジェクトごとの指定

```bash
asdf set nodejs 18.20.5
asdf set python 3.12.8
```
