# doctor.sh

## 現在の判定方針

`doctor.sh` は以下を区別します。

- **FAIL**: 必須コマンドがない、または構文エラーなど本当に直すべきもの
- **WARN**: あると便利、または未反映だが致命的ではないもの
- **PASS**: 問題なし

## よくあるWARN

### gh not found

GitHub CLIが未導入です。

```bash
brew install gh
gh auth login
```

### ~/.gitignore_global missing

dotfilesにある `.gitignore_global` をホームにコピーします。

```bash
cp .gitignore_global ~/.gitignore_global
```

### Brewfile dependencies not fully satisfied

Brewfileに書かれているものが未導入です。

```bash
brew bundle --file Brewfile
```

### VS Code extensions count differs

VS Codeに入っている拡張と、`vscode/extensions.txt` の数が違います。

```bash
code --list-extensions | sort > vscode/extensions.txt
```

## 秘密情報スキャン

`doctor.sh` は高リスクな秘密情報パターンだけを検出します。

検出対象例:

- SSH private key
- GitHub token
- AWS Access Key
- Slack token

`tokenizer` のような通常語は検出しないようにしています。
