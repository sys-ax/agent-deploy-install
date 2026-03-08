# Tmux Setup Installer

Secure installer for the private `sys-ax/tmux-setup` repository.

## Install (Recommended)

Clone the installer repo, verify, then run:

```bash
git clone https://github.com/sys-ax/tmux-setup-installme.git
cd tmux-setup-installme
shasum -a 256 -c CHECKSUMS.sha256
bash install.sh
```

## Install (Quick)

Download and auto-verify:

```bash
curl -fsSL https://raw.githubusercontent.com/sys-ax/tmux-setup-installme/main/install.sh | bash
```

When piped, the installer automatically downloads all verification files, checks SHA256 checksums and the Ed25519 signature, then re-executes the verified copy. Unverified code never runs.

## Security

- **Mandatory signature verification** — Ed25519 key with pinned fingerprint; no skip option
- **Checksum verification** — SHA256 for all installer files and `setup.sh`
- **Pipe-to-bash safety** — Downloads, verifies, then executes; never runs piped input directly
- **Token scope auditing** — Warns about excessive GitHub token permissions
- **Install logging** — Full audit trail at `~/.installer-log/`

### Verifying Manually

```bash
# Check file integrity
shasum -a 256 -c CHECKSUMS.sha256

# Check signing key fingerprint
ssh-keygen -lf signing-key.pub
# Expected: SHA256:UWg7JA3vAQ2D/fN+tUUAzdkIhEoorKEY5KIbxrVlRE0

# Verify script signature
echo "alejandroyu@github.com $(cat signing-key.pub)" > /tmp/allowed_signers
ssh-keygen -Y verify -f /tmp/allowed_signers -I alejandroyu@github.com -n file -s install.sh.sig < install.sh
rm /tmp/allowed_signers
```

## Requirements

- [GitHub CLI](https://cli.github.com/) (`brew install gh`)
- Authenticated: `gh auth login`
- Access to `sys-ax/tmux-setup` (private)
