# Dock Settings

## Dockを自動的に隠す

```bash
defaults write com.apple.dock autohide -bool true
killall Dock
```

## Dockサイズ変更

```bash
defaults write com.apple.dock tilesize -int 42
killall Dock
```

## 最近使ったアプリを非表示

```bash
defaults write com.apple.dock show-recents -bool false
killall Dock
```
