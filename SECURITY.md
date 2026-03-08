# how it works

nothing runs unverified. ever.

## the chain

1. ed25519 sig on `install.sh` — key fingerprint pinned in the script itself
2. sha256 checksums on all files
3. `setup.sh` from the private repo checksummed before execution
4. piped input (`curl | bash`) is downloaded to `/tmp`, verified, then `exec`d

no skip. no "continue anyway?". missing files get fetched and verified automatically.

## verify yourself

```
shasum -a 256 -c CHECKSUMS.sha256
ssh-keygen -lf signing-key.pub
# expect: SHA256:UWg7JA3vAQ2D/fN+tUUAzdkIhEoorKEY5KIbxrVlRE0
```

## what else

- gh token scope audit — warns if you have more access than needed
- install log at `~/.installer-log/`
- `set -euo pipefail`, trap on EXIT/INT/TERM

## found something?

open an issue or reach out directly. don't post exploits publicly.
