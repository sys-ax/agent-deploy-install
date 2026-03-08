# how it works

nothing runs unverified. ever.

## the chain

1. ed25519 signing key embedded in `install.sh` — no external `signing-key.pub` to tamper with
2. key fingerprint pinned and verified before every signature check
3. sha256 checksums on `install.sh` + `install.sh.sig` (defense in depth)
4. `setup.sh` from the private repo checksummed before execution
5. `SCRIPTS-CHECKSUMS.sha256` verifies all scripts before they're copied to `~/.local/bin/`
6. piped input (`curl | bash`) is downloaded to `/tmp`, verified, then `exec`d
7. npm packages installed with `--ignore-scripts` to block post-install code execution
8. Node.js installed via GPG-signed apt repo, not `curl | bash`

no skip. no "continue anyway?". no external key files. no post-install scripts.

## signing

the signing key lives in 1Password (`signing-installer-sysax` in the Keys vault). no disk keys — 1P is the single source of truth.

to re-sign after any changes:

```
cd /path/to/tmux-setup && bash sign.sh [/path/to/tmux-setup-installme]
```

this pulls the key from 1P, regenerates all checksums (scripts + setup.sh), signs install.sh, and verifies everything. the key never touches disk outside a temp file that's cleaned up on exit.

to verify without 1P access:

```
bash sign.sh verify [/path/to/tmux-setup-installme]
```

## verify yourself

```
shasum -a 256 -c CHECKSUMS.sha256
# the signing key is embedded in install.sh — no external file needed
# fingerprint: SHA256:UWg7JA3vAQ2D/fN+tUUAzdkIhEoorKEY5KIbxrVlRE0
```

## what else

- gh token scope audit — warns if you have more access than needed
- install log at `~/.installer-log/`
- `set -euo pipefail`, trap on EXIT/INT/TERM
- every script in the private repo is checksummed before installation

## found something?

open an issue or reach out directly. don't post exploits publicly.
