#!/usr/bin/env -S make -f

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL := all
DEBUG ?=
MAIN_MAKEFILE := $(word 1, $(MAKEFILE_LIST))
BINARIES := $(shell grep -oE '^\s*\.local/bin/[^ :]+' $(MAIN_MAKEFILE))

# This target is used instead of .PHONY for modularity
# See: https://www.gnu.org/software/make/manual/html_node/Force-Targets.html
FORCE:

.local/bin/uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

latest-python: .local/bin/uv FORCE
	uv python install

.local/bin/xonsh: latest-python
	uv tool install xonsh --with trezor-agent

.local/bin/trezor-agent: .local/bin/xonsh

# community distribution
.local/bin/ansible-community: latest-python
	uv tool install ansible

# RH distribution
.local/bin/ansible:
	uv tool install ansible-core

all: $(BINARIES)
