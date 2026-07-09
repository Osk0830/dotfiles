install:
	./install.sh

doctor:
	./scripts/doctor.sh

vscode-install:
	./scripts/install-vscode-extensions.sh

vscode-export:
	./scripts/export-vscode-extensions.sh

aliases:
	./scripts/setup-gh-aliases.sh

defaults:
	./scripts/mac-defaults.sh

check:
	zsh -n .zshrc
	zsh -n .zprofile
	bash -n install.sh
	bash -n scripts/*.sh

update-brew:
	brew bundle dump --force

update-vscode:
	./scripts/export-vscode-extensions.sh

.PHONY: install doctor vscode-install vscode-export aliases defaults check update-brew update-vscode
