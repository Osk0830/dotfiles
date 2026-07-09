# GitHub CLI Aliases

## おすすめalias

```bash
gh alias set co "pr checkout"
gh alias set prs "pr status"
gh alias set pv "pr view"
gh alias set pc "pr create"
gh alias set pm "pr merge"
gh alias set rl "repo list"
```

## 確認

```bash
gh alias list
```

## Export

```bash
gh alias list > github/aliases.export.txt
```

## 注意

alias自体は秘密情報ではありません。

ただし、特定の会社名・案件名・private repo名が含まれるaliasはコミットしない方が安全です。
