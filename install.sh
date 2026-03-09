#!/bin/bash
# curl -fsSL https://raw.githubusercontent.com/sys-ax/agent-deploy-install/main/install.sh | bash
set -euo pipefail

echo "agent-deploy installer"
echo ""

# gh required
if ! command -v gh &>/dev/null; then
  echo "Install GitHub CLI first: https://cli.github.com"
  exit 1
fi

# auth required
if ! gh auth status &>/dev/null; then
  echo "Run: gh auth login"
  exit 1
fi

# clone + run
T=$(mktemp -d)
trap "rm -rf '$T'" EXIT
gh repo clone sys-ax/agent-deploy "$T/agent-deploy" -- --depth 1 2>/dev/null || { echo "No access to sys-ax/agent-deploy"; exit 1; }
exec bash "$T/agent-deploy/install.sh"
