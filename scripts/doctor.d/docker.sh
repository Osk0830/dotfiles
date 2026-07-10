#!/usr/bin/env bash

check_docker() {
  section "Docker Desktop"

  if [ -d "/Applications/Docker.app" ]; then
    pass "Docker Desktop app exists: /Applications/Docker.app"

    local desktop_version
    desktop_version="$(
      defaults read /Applications/Docker.app/Contents/Info CFBundleShortVersionString 2>/dev/null || true
    )"
    [ -n "$desktop_version" ] && info "Docker Desktop version: $desktop_version"
  elif [ -d "$HOME/Applications/Docker.app" ]; then
    pass "Docker Desktop app exists: $HOME/Applications/Docker.app"
  else
    fail "Docker Desktop app not found"
    echo "  install manually and see: $DOTFILES_DIR/mac/docker.md"
  fi

  if ! exists docker; then
    fail "docker CLI not found"
    echo "  Start Docker Desktop, then open a new terminal."
    return
  fi

  pass "docker CLI: $(command -v docker)"
  docker --version || true

  if docker info >/dev/null 2>&1; then
    pass "Docker daemon is running"

    local server_version
    server_version="$(docker version --format '{{.Server.Version}}' 2>/dev/null || true)"
    [ -n "$server_version" ] && info "Docker Engine version: $server_version"
  else
    warn "Docker CLI exists, but the daemon is unavailable"
    echo "  1. Start Docker Desktop"
    echo "  2. Wait until the engine is running"
    echo "  3. Run: docker info"
  fi

  if docker compose version >/dev/null 2>&1; then
    pass "Docker Compose plugin is available"
    docker compose version || true
  else
    warn "Docker Compose plugin is unavailable"
  fi

  local docker_context
  docker_context="$(docker context show 2>/dev/null || true)"
  if [ -n "$docker_context" ]; then
    pass "Docker context: $docker_context"
  else
    warn "Could not determine Docker context"
  fi
}
