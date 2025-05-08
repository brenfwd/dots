STOW := stow -v -d . -t ~
PACKAGES := bash git ssh nvim fonts

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

