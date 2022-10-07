#!/bin/sh

# Always copy using reflinks and sparse file processing
alias cp='cp --reflink=auto --sparse=always'

# Atom throws an error when launching this way
if [ "$LIBGL_ALWAYS_INDIRECT" == "1" ]; then
  alias atom="atom --in-process-gpu"
fi
