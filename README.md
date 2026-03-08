```
git clone https://github.com/sys-ax/tmux-setup-installme.git && cd tmux-setup-installme && bash install.sh
```

or

```
curl -fsSL https://raw.githubusercontent.com/sys-ax/tmux-setup-installme/main/install.sh | bash
```

needs `gh` authenticated. piped input is never executed raw — it downloads, verifies sig + checksums, then runs the verified copy.

see `SECURITY.md` if you care how.
