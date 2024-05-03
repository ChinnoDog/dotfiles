#!/bin/sh
# Configure bash environment

# Add local bin
p=~/.local/bin
[[ ":$PATH:" != *":$p:"* ]] && PATH="$p:${PATH}"

# Always copy using reflinks and sparse file processing
alias cp='cp --reflink=auto --sparse=always'

# Atom throws an error when launching this way
if [ "$LIBGL_ALWAYS_INDIRECT" == "1" ]; then
  alias atom="atom --in-process-gpu"
fi

# Command for reloading environment in tmux
alias tmux-env-reload='eval $(tmux show-environment -s)'
