SHELL := /bin/bash
SIGNING_KEY := ~/.ssh/alejandroyu-tmux-setup-signing
SIGNING_ID := alejandroyu@github.com
FILES := install.sh install.sh.sig signing-key.pub

.PHONY: sign verify checksums release clean

sign:
	ssh-keygen -Y sign -f $(SIGNING_KEY) -n file install.sh

checksums:
	shasum -a 256 $(FILES) > CHECKSUMS.sha256

verify:
	@shasum -a 256 -c CHECKSUMS.sha256
	@echo "$(SIGNING_ID) $$(cat signing-key.pub)" > /tmp/_allowed_signers
	@ssh-keygen -Y verify -f /tmp/_allowed_signers -I $(SIGNING_ID) -n file -s install.sh.sig < install.sh
	@rm -f /tmp/_allowed_signers
	@echo "--- all checks passed ---"

release: sign checksums verify
	git add install.sh install.sh.sig signing-key.pub CHECKSUMS.sha256
	@echo "staged. review with 'git diff --cached' then commit."

clean:
	rm -f /tmp/_allowed_signers
