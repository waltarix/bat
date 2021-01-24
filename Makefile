ifeq ($(RUST_TARGET),)
	TARGET := ""
	RELEASE_SUFFIX := ""
else
	TARGET := $(RUST_TARGET)
	RELEASE_SUFFIX := "-$(TARGET)"
	export CARGO_BUILD_TARGET = $(RUST_TARGET)
endif

VERSION := $(word 3,$(shell grep -m1 "^version" Cargo.toml))
RELEASE := bat-$(VERSION)$(RELEASE_SUFFIX)

DIST_DIR := dist
COMPLETIONS_DIR := $(DIST_DIR)/autocomplete

BINARY := $(DIST_DIR)/bat
MANUAL := $(DIST_DIR)/bat.1
COMPLETION_FILES := bat.fish bat.zsh
COMPLETIONS := $(addprefix $(COMPLETIONS_DIR)/,$(COMPLETION_FILES))

all: release

build:
	cargo build --locked --release

$(DIST_DIR) $(COMPLETIONS_DIR):
	mkdir -p $@

$(BINARY): build $(DIST_DIR)
	cp -f target/$(TARGET)/release/bat $@

$(MANUAL): build $(DIST_DIR)
	cp -f target/$(TARGET)/release/build/*/out/assets/manual/bat.1 $@

$(COMPLETIONS): build $(COMPLETIONS_DIR)
	cp -f target/$(TARGET)/release/build/*/out/assets/completions/$(notdir $@) $@

release: $(BINARY) $(MANUAL) $(COMPLETIONS)
	tar --strip-components 1 -Jcvf $(RELEASE).tar.xz dist

.PHONY: all build release
