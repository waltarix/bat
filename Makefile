ifeq ($(RUST_TARGET),)
	TARGET :=
	RELEASE_SUFFIX :=
else
	TARGET := $(RUST_TARGET)
	RELEASE_SUFFIX := -$(TARGET)
	export CARGO_BUILD_TARGET = $(RUST_TARGET)
endif

PROJECT_NAME := bat

VERSION := $(subst $\",,$(word 3,$(shell grep -m1 "^version" Cargo.toml)))
RELEASE := $(PROJECT_NAME)-$(VERSION)$(RELEASE_SUFFIX)

DIST_DIR := dist
RELEASE_DIR := $(DIST_DIR)/$(RELEASE)
COMPLETIONS_DIR := $(RELEASE_DIR)/etc/completions
MANUAL_DIR := $(RELEASE_DIR)/manual

BINARY := target/$(TARGET)/release/$(PROJECT_NAME)

RELEASE_BINARY := $(RELEASE_DIR)/$(PROJECT_NAME)
MANUAL := $(MANUAL_DIR)/$(PROJECT_NAME).1
COMPLETION_FILES := $(addprefix bat., fish zsh bash)
COMPLETIONS := $(addprefix $(COMPLETIONS_DIR)/,$(COMPLETION_FILES))

ARTIFACT := $(RELEASE).tar.xz

.PHONY: all
all: $(ARTIFACT)

$(BINARY):
	RUSTFLAGS='-C link-args=-s' cargo build --locked --release

$(DIST_DIR) $(RELEASE_DIR) $(COMPLETIONS_DIR) $(MANUAL_DIR):
	mkdir -p $@

$(RELEASE_BINARY): $(BINARY) $(RELEASE_DIR)
	cp -f $< $@

$(COMPLETIONS): $(COMPLETIONS_DIR)
	find target/$(TARGET)/release/build/bat-*/out/assets/completions/$(@F) -print0 -quit \
		| xargs -0 cp -t $<

$(MANUAL): $(MANUAL_DIR)
	find target/$(TARGET)/release/build/bat-*/out/assets/manual/$(@F) -print0 -quit \
		| xargs -0 cp -t $<

$(ARTIFACT): $(RELEASE_BINARY) $(MANUAL) $(COMPLETIONS)
	tar -C $(DIST_DIR) -Jcvf $@ $(RELEASE)

.PHONY: clean
clean:
	$(RM) -rf $(ARTIFACT) $(DIST_DIR)
