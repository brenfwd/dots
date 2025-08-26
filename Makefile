STOW := stow -v -d . -t ~
PACKAGES := bash nvim fonts tmux fish

FIND_BIN ?= find

install:
	$(STOW) $(PACKAGES)
.PHONY: install

uninstall:
	$(STOW) -D $(PACKAGES)
.PHONY: uninstall

# Lists all broken symlinks in home dir
findbroken:
	$(FIND_BIN) ~ -xtype l
.PHONY: findbroken

