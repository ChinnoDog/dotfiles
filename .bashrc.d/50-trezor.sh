#!/bin/sh
# use trezor for gpg signing if available
if [ -d ~/.gnupg/trezor ]; then
  export GNUPGHOME=~/.gnupg/trezor
fi
