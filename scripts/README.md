# doctor.sh リファクタリング

`doctor.sh` を機能別モジュールへ分割した差し替えセットです。

## 構成

```text
scripts/
├── doctor.sh
└── doctor.d/
    ├── common.sh
    ├── repository.sh
    ├── shell.sh
    ├── commands.sh
    ├── git.sh
    ├── asdf.sh
    ├── github.sh
    ├── ssh.sh
    ├── docker.sh
    ├── vscode.sh
    ├── homebrew.sh
    ├── documentation.sh
    └── security.sh
```

## 適用

このZIPをdotfilesとは別のディレクトリへ展開して実行します。

```bash
chmod +x apply.sh
./apply.sh /Users/hsg/dotfiles
```

## 確認

```bash
cd /Users/hsg/dotfiles
bash -n scripts/doctor.sh scripts/doctor.d/*.sh
./scripts/doctor.sh
./scripts/doctor.sh --strict --network
```

`apply.sh` は既存の `scripts/doctor.sh` と `scripts/doctor.d/` を
`.doctor-refactor-backup-YYYYMMDDHHMMSS/` へ退避してから差し替えます。
