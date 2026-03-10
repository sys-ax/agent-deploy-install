#!/bin/bash
# curl -fsSL https://raw.githubusercontent.com/sys-ax/agent-deploy-install/main/install.sh | bash
set -euo pipefail

echo "agent-deploy installer"
echo ""

# ─── Install gh if missing ───────────────────────────────────────────────────
if ! command -v gh &>/dev/null; then
  echo "GitHub CLI not found. Installing..."
  if [[ "$(uname)" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
      brew install gh
    else
      echo "Homebrew not found. Install gh manually: https://cli.github.com"
      exit 1
    fi
  elif [[ "$(uname)" == "Linux" ]]; then
    if command -v apt-get &>/dev/null; then
      (type -p wget >/dev/null || sudo apt-get install wget -y) \
        && sudo mkdir -p -m 755 /etc/apt/keyrings \
        && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null \
        && sudo apt-get update && sudo apt-get install gh -y
    elif command -v dnf &>/dev/null; then
      sudo dnf install -y gh
    elif command -v yum &>/dev/null; then
      sudo yum install -y gh
    else
      echo "Could not auto-install gh. Install manually: https://cli.github.com"
      exit 1
    fi
  else
    echo "Unsupported OS. Install gh manually: https://cli.github.com"
    exit 1
  fi
  echo ""
fi

# ─── Auth if not logged in ───────────────────────────────────────────────────
if ! gh auth status &>/dev/null; then
  echo "Not logged in to GitHub. Starting device auth flow..."
  echo ""
  gh auth login --hostname github.com --git-protocol https --web 2>&1
  echo ""
  if ! gh auth status &>/dev/null; then
    echo "Authentication failed."
    exit 1
  fi
fi

# ─── Clone + run ─────────────────────────────────────────────────────────────
T=$(mktemp -d)
trap "rm -rf '$T'" EXIT
gh repo clone sys-ax/agent-deploy "$T/agent-deploy" -- --depth 1 2>/dev/null || { echo "No access to sys-ax/agent-deploy"; exit 1; }
exec bash "$T/agent-deploy/install.sh"
