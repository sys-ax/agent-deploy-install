# Tmux Setup Installer

Secure installer for the private `tmux-setup` repository. **Cryptographically signed by @alejandroyu.**

## Quick Install

### Verify Signature (Recommended)

```bash
# Download files
curl -fsSL -O https://raw.githubusercontent.com/alejandroyu2/tmux-setup-installme/main/install.sh
curl -fsSL -O https://raw.githubusercontent.com/alejandroyu2/tmux-setup-installme/main/install.sh.sig
curl -fsSL -O https://raw.githubusercontent.com/alejandroyu2/tmux-setup-installme/main/alejandroyu.pub

# Verify signature (checks it's from @alejandroyu)
ssh-keygen -Y verify -f alejandroyu.pub -I alejandroyu@github.com -n file -s install.sh.sig < install.sh

# If signature is valid: "Good "file" signature verified"
# Then run:
bash install.sh
```

### Or Run Directly (Trust Mode)

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

### Signature Verification

✅ **Cryptographically signed** - Ed25519 key signed by @alejandroyu
✅ **Public key included** - `alejandroyu.pub` verifies authenticity
✅ **Tamper detection** - Signature fails if script is modified
✅ **GitHub verified** - Linked to alejandroyu GitHub account

### Why This Matters

- **Without signature**: Script could be intercepted/modified
- **With signature**: Only script signed by @alejandroyu's key will verify
- **You choose**: Verify before running, or trust and run directly

## Key Details

- **Key Type**: Ed25519 (NSA Suite B recommended, strongest modern cryptography)
- **Key ID**: `SHA256:UWg7JA3vAQ2D/fN+tUUAzdkIhEoorKEY5KIbxrVlRE0`
- **Owner**: alejandroyu@github.com
- **Usage**: Signing installer releases

## Troubleshooting

**"Signature verification failed"**
- Script was modified (integrity check failed)
- Key mismatch (wrong public key)
- Download corruption (try again)

**"Good signature verified"**
- ✅ Script is authentic and unmodified
- ✅ Safe to run

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

View the public signing key:
```bash
curl -fsSL https://raw.githubusercontent.com/alejandroyu2/tmux-setup-installme/main/alejandroyu.pub
```

---

**Questions?** Check the script or the private repo docs.
