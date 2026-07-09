#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

green="\033[1;32m"
yellow="\033[1;33m"
red="\033[1;31m"
cyan="\033[1;36m"
reset="\033[0m"

pass_count=0
warn_count=0
fail_count=0

section() {
  printf "\n${cyan}== %s ==${reset}\n" "$1"
}

pass() {
  printf "${green}✔${reset} %s\n" "$1"
  pass_count=$((pass_count + 1))
}

warn() {
  printf "${yellow}⚠${reset} %s\n" "$1"
  warn_count=$((warn_count + 1))
}

fail() {
  printf "${red}✘${reset} %s\n" "$1"
  fail_count=$((fail_count + 1))
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

show_cmd_required() {
  local cmd="$1"

  if exists "$cmd"; then
    local path
    path="$(command -v "$cmd")"
    pass "$cmd: $path"

    case "$cmd" in
      node) node -v || true ;;
      python) python --version || true ;;
      pip) pip --version || true ;;
      git) git --version || true ;;
      docker) docker --version || true ;;
      code) code --version | head -n1 || true ;;
      mkdocs) mkdocs --version || true ;;
      brew) brew --version | head -n1 || true ;;
      asdf) asdf --version || true ;;
      rg) rg --version | head -n1 || true ;;
      tree) tree --version | head -n1 || true ;;
    esac
  else
    fail "$cmd: not found"
  fi
}

show_cmd_optional() {
  local cmd="$1"

  if exists "$cmd"; then
    local path
    path="$(command -v "$cmd")"
    pass "$cmd: $path"

    case "$cmd" in
      gh) gh --version | head -n1 || true ;;
      jq) jq --version || true ;;
      pnpm) pnpm -v || true ;;
    esac
  else
    warn "$cmd: not found"
  fi
}

section "Repository"

if [ -d "$DOTFILES_DIR/.git" ]; then
  pass "dotfiles is a git repository"

  status_output="$(git -C "$DOTFILES_DIR" status --short || true)"
  if [ -n "$status_output" ]; then
    warn "working tree has changes:"
    echo "$status_output"
  else
    pass "working tree clean"
  fi
else
  warn "dotfiles is not a git repository: $DOTFILES_DIR"
fi

section "Shell files"

for file in "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.gitconfig" "$HOME/.tool-versions"; do
  if [ -f "$file" ]; then
    pass "exists: $file"
  else
    warn "missing: $file"
  fi
done

if [ -f "$HOME/.gitignore_global" ]; then
  pass "exists: $HOME/.gitignore_global"
else
  warn "missing: $HOME/.gitignore_global"
  echo "  fix: cp \"$DOTFILES_DIR/.gitignore_global\" \"$HOME/.gitignore_global\""
fi

if [ -f "$HOME/.zshrc" ]; then
  zsh -n "$HOME/.zshrc" && pass "~/.zshrc syntax OK" || fail "~/.zshrc syntax error"
fi

if [ -f "$HOME/.zprofile" ]; then
  zsh -n "$HOME/.zprofile" && pass "~/.zprofile syntax OK" || fail "~/.zprofile syntax error"
fi

section "Core commands"

for cmd in git brew asdf node python pip docker code mkdocs rg tree; do
  show_cmd_required "$cmd"
done

for cmd in gh jq pnpm; do
  show_cmd_optional "$cmd"
done

section "asdf"

if exists asdf; then
  echo ""
  asdf current || true
  echo ""

  if asdf plugin list | grep -qx "nodejs"; then
    pass "asdf plugin nodejs"
  else
    warn "asdf plugin nodejs missing"
  fi

  if asdf plugin list | grep -qx "python"; then
    pass "asdf plugin python"
  else
    warn "asdf plugin python missing"
  fi

  if [ -f "$HOME/.tool-versions" ]; then
    if grep -q "^nodejs 22.15.0" "$HOME/.tool-versions"; then
      pass "global nodejs 22.15.0"
    else
      warn "global nodejs 22.15.0 not found in ~/.tool-versions"
    fi

    if grep -q "^python 3.12.8" "$HOME/.tool-versions"; then
      pass "global python 3.12.8"
    else
      warn "global python 3.12.8 not found in ~/.tool-versions"
    fi
  fi
fi

section "Python / MkDocs"

if exists python && python --version 2>&1 | grep -q "3.12.8"; then
  pass "Python 3.12.8 active"
else
  warn "Python 3.12.8 is not active"
fi

if exists mkdocs; then
  pass "MkDocs available"
else
  warn "MkDocs not found. Run: pip install mkdocs-material"
fi

section "Node / pnpm"

if exists node && node -v | grep -q "v22.15.0"; then
  pass "Node.js 22.15.0 active"
else
  warn "Node.js 22.15.0 is not active"
fi

if exists pnpm; then
  pass "pnpm available: $(pnpm -v)"
else
  warn "pnpm not found. Try: corepack enable"
fi

section "GitHub CLI"

if exists gh; then
  if gh auth status >/dev/null 2>&1; then
    pass "gh authenticated"
  else
    warn "gh is installed but not authenticated. Run: gh auth login"
  fi
else
  warn "gh not found. Install with: brew install gh"
fi

section "SSH"

if [ -f "$HOME/.ssh/id_ed25519" ]; then
  pass "SSH private key exists: ~/.ssh/id_ed25519"
else
  warn "SSH private key missing: ~/.ssh/id_ed25519"
fi

if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
  pass "SSH public key exists: ~/.ssh/id_ed25519.pub"
else
  warn "SSH public key missing: ~/.ssh/id_ed25519.pub"
fi

if [ -f "$HOME/.ssh/config" ]; then
  pass "SSH config exists"
else
  warn "SSH config missing"
fi

section "Docker"

if exists docker; then
  if docker info >/dev/null 2>&1; then
    pass "Docker daemon running"
  else
    warn "Docker installed but daemon is not running"
  fi
fi

section "VS Code"

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if [ -d "$VSCODE_USER_DIR" ]; then
  pass "VS Code user dir exists"
else
  warn "VS Code user dir missing"
fi

if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
  pass "VS Code settings.json exists"
else
  warn "VS Code settings.json missing"
fi

if [ -f "$VSCODE_USER_DIR/keybindings.json" ]; then
  pass "VS Code keybindings.json exists"
else
  warn "VS Code keybindings.json missing"
fi

if exists code && [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
  installed_count="$(code --list-extensions | wc -l | tr -d ' ')"
  managed_count="$(grep -v '^#' "$DOTFILES_DIR/vscode/extensions.txt" | grep -v '^$' | wc -l | tr -d ' ')"

  if [ "$installed_count" = "$managed_count" ]; then
    pass "VS Code extensions installed: $installed_count / managed: $managed_count"
  else
    warn "VS Code extensions count differs: installed $installed_count / managed $managed_count"
    echo "  fix: code --list-extensions | sort > vscode/extensions.txt"
  fi
fi

section "Homebrew"

if exists brew; then
  if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    if brew bundle check --file "$DOTFILES_DIR/Brewfile" >/dev/null 2>&1; then
      pass "Brewfile dependencies satisfied"
    else
      warn "Brewfile dependencies not fully satisfied."
      echo "  fix: brew bundle --file \"$DOTFILES_DIR/Brewfile\""
    fi
  else
    warn "Brewfile not found"
  fi
fi

section "Security quick scan"

if exists rg; then
  # Focus on high-signal secret patterns.
  # Avoid generic words like token/secret/password because docs and PHP stubs cause many false positives.
  if rg -n "BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY|ghp_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}" "$DOTFILES_DIR" \
    --glob '!docs/security.md' \
    --glob '!scripts/doctor.sh' >/tmp/dotfiles_secret_scan.txt 2>/dev/null; then
    warn "Potential high-signal secret strings found:"
    cat /tmp/dotfiles_secret_scan.txt
  else
    pass "No high-signal secret-like strings found"
  fi
else
  warn "rg not found. Skipped secret quick scan."
fi

section "Summary"

echo "PASS: $pass_count"
echo "WARN: $warn_count"
echo "FAIL: $fail_count"

# doctor exits non-zero only for real required command/syntax failures.
if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
