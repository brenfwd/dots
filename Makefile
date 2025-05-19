STOW := stow -v -d . -t ~
PACKAGES := bash nvim fonts zed

install:
	$(STOW) $(PACKAGES)
.PHONY: install

uninstall:
	$(STOW) -D $(PACKAGES)
.PHONY: uninstall

# Lists all broken symlinks in home dir
findbroken:
	find ~ -xtype l
.PHONY: findbroken

