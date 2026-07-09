# known_hosts

## GitHubのknown_hostsを登録する

通常は初回接続時に登録されます。

```bash
ssh -T git@github.com
```

明示的に追加する場合:

```bash
ssh-keyscan github.com >> ~/.ssh/known_hosts
```

## 注意

`known_hosts` には接続先情報が含まれます。

通常はdotfilesで管理しなくてOKです。
