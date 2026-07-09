#!/usr/bin/env bash
set -euo pipefail

gh alias set co "pr checkout"
gh alias set prs "pr status"
gh alias set pv "pr view"
gh alias set pc "pr create"
gh alias set pm "pr merge"
gh alias set rl "repo list"

gh alias list
