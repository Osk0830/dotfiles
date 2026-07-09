# Finder Settings

## おすすめ

- 拡張子を表示
- 隠しファイルを表示
- パスバーを表示
- ステータスバーを表示
- デフォルト表示をリストにする

## コマンド

```bash
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
killall Finder
```
