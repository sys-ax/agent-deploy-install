# Tmux Setup Installer

Secure installer for the private `tmux-setup` repository.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/alejandroyu2/tmux-setup-installme/main/install.sh | bash
```

## What It Does

1. ✅ Checks for GitHub CLI (`gh`)
2. ✅ Verifies you're authenticated with GitHub
3. ✅ Verifies you have access to the private repo
4. ✅ Clones `alejandroyu2/tmux-setup`
5. ✅ Runs its setup script

**That's it.** No passwords. No tokens. No secrets in the script.

## Requirements

- **GitHub CLI**: `brew install gh`
- **GitHub Authentication**: `gh auth login`
- **Access** to `alejandroyu2/tmux-setup` (private repo)

## Security

This is more secure than typical `curl | bash`:

✅ **Public and auditable** - Anyone can review this script
✅ **No embedded secrets** - No tokens or passwords in code
✅ **GitHub auth verification** - Checks you have access before installing
✅ **Private repo only** - Only installs from your private repository

## Troubleshooting

**"GitHub CLI not found"**
```bash
brew install gh
```

**"Not authenticated with GitHub"**
```bash
gh auth login
```

**"No access to alejandroyu2/tmux-setup"**

Request access to the private repository.

## Source Code

This entire script is 100 lines and 100% visible. Read it before running.

```bash
curl -fsSL https://raw.githubusercontent.com/alejandroyu2/tmux-setup-installme/main/install.sh
```

Then execute when you're confident.

---

**Questions?** Check the script or the private repo docs.
