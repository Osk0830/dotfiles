# macOS defaults

## 注意

このファイルは設定候補です。

実行前に内容を確認してください。

## Finder

拡張子を表示:

```bash
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
```

隠しファイルを表示:

```bash
defaults write com.apple.finder AppleShowAllFiles -bool true
```

パスバーを表示:

```bash
defaults write com.apple.finder ShowPathbar -bool true
```

ステータスバーを表示:

```bash
defaults write com.apple.finder ShowStatusBar -bool true
```

Finder再起動:

```bash
killall Finder
```

## スクリーンショット保存先

```bash
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots
killall SystemUIServer
```
