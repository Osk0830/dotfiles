# Keyboard Settings

## キーリピートを速くする

```bash
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
```

## 長押しアクセントメニューを無効化

```bash
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

反映にはログアウトまたは再起動が必要な場合があります。
