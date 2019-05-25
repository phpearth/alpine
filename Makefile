MAKE_VERSION_MAJOR := $(shell $(MAKE) -version | sed -ne 's/^GNU Make \([0-9]\).*/\1/p')

ifeq ($(shell test $(MAKE_VERSION_MAJOR) -lt 4; echo $$?),0)
unsupported-make:
	@echo "This version of make is unsupported, GNU Make >= 4 is needed"
	@echo "For macOS install brew install make"
else
	include .make.mk
endif
