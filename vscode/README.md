# VS Code

## 管理するもの

- `settings.json`
- `keybindings.json`
- `extensions.txt`
- `profiles.md`
- `recommended-extensions.md`

---

## settings.jsonを反映

```bash
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
```

---

## keybindings.jsonを反映

```bash
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
```

---

## 拡張機能を保存

```bash
./scripts/export-vscode-extensions.sh
```

または:

```bash
code --list-extensions | sort > vscode/extensions.txt
```

---

## 拡張機能を復元

```bash
./scripts/install-vscode-extensions.sh
```

または:

```bash
xargs -n 1 code --install-extension < vscode/extensions.txt
```

---

## Profileは必要？

最初は必須ではありません。

まずは以下で十分です。

- settings.json
- keybindings.json
- extensions.txt

PHP用、React用、Python用などを分けたくなったら、VS Code Profilesを使います。

```text
Preferences → Profiles → Export Profile
```

---

## 注意

`chat.tools.terminal.autoApprove` のような案件固有パスを含む設定は、基本的にdotfilesへ入れません。
