# ==================================================
# ~/.zprofile
# ==================================================
# Login shell initialization.
#
# Keep this file minimal.
# Put interactive shell settings in ~/.zshrc.
# ==================================================

# Homebrew (Apple Silicon)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
