#!/usr/bin/env -S make -f
# Install and launch xonsh

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL := launch-xonsh
DEBUG ?=

# This target is used instead of .PHONY for modularity
# See: https://www.gnu.org/software/make/manual/html_node/Force-Targets.html
FORCE:

define deadsnakes-check
	bash -c 'set -o pipefail; \
	apt-add-repository --list | grep -q deadsnakes \
	; echo $$?'
endef

deadsnakes-repo: FORCE
	@if [ $$($(deadsnakes-check)) -ne 0 ]; then
		sudo apt-add-repository -y ppa:deadsnakes/ppa
		sudo apt update
	else
		$(if $(DEBUG), $(info deadsnakes repo already present))
		true
	fi

python-latest-package := $(shell bash -c "set -o pipefail; \
apt-cache search -n \"^python3\\.[0-9]+$$\" | cut -f1 -d' ' | xargs -I{} bash -c \
\"echo -n '{} '; apt-cache policy {} | grep 'Candidate:' | xargs | cut -f2 -d' '\" \
| grep -vE \"~(a|b|rc)\" | cut -f1 -d' ' | sort -Vr | head -n 1")

#python-latest-package := $(shell bash -c 'set -o pipefail; \
#apt-cache search -n "^python3\.[0-9]+$$" \
#| cut -f1 -d" " | sort -Vr | head -n 1 ')

define python3-latest-packages
	$(python-latest-package) \
	$(python-latest-package)-venv \
	$(python-latest-package)-dev \
	libffi-dev
endef

python3-latest: FORCE deadsnakes-repo
	@if ! dpkg-query -W $(python3-latest-packages) \
		$(if $(DEBUG),,>/dev/null 2>&1); then
		sudo apt install -y $(python3-latest-packages)
	fi

trezor-udev: FORCE
	@if ! dpkg-query -W trezor-udev \
		$(if $(DEBUG),,>/dev/null 2>&1); then
		curl -o /tmp/trezor-udev.deb https://data.trezor.io/udev/trezor-udev_2_all.deb
		sudo apt install -y /tmp/trezor-udev.deb
	fi

# The convenient path I will type
.venvs:
	mkdir -p .local/share/venvs  # XDG Base Directory Specification
	ln -s .local/share/venvs $@  # The easy location

vnow := $(shell test -x .venvs/xonsh/bin/python && .venvs/xonsh/bin/python -V || true)
vlatest := $(shell test -x /bin/$(python-latest-package) &&  /bin/$(python-latest-package) -V || true)

# The venv for xonsh
.venvs/xonsh: .venvs python3-latest FORCE
	@if [ -f $@/bin/python ]; then
#		vnow=$$($@/bin/python -V)
#		vlatest=$$(/bin/$(python-latest-package) -V)
		$(if $(DEBUG), $(info Latest python is $(vlatest), venv python is $(vnow)))
		@if [ "$(vnow)" != "$(vlatest)" ]; then
			$(if $(DEBUG), $(info Deleting venv because of version mismatch))
			rm -rf $@
		else
			$(if $(DEBUG), $(info $@ version is latest))
			true
		fi
	fi
	@if [ ! -d $@ ]; then
		$(if $(DEBUG), $(info Creating $@))
		$(python-latest-package) -m venv $@ --without-pip
	fi

.venvs/xonsh/bin/xonsh: .venvs/xonsh
	source $</bin/activate
	python3 -m ensurepip --default-pip
	pip install \
		xonsh \
		setuptools \
		wheel \
		trezor-agent \
		;

launch-xonsh: .venvs/xonsh/bin/xonsh trezor-udev FORCE
	$(if $(DEBUG), ,@)$<
