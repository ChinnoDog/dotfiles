#!/bin/sh
# Initialize ruby environment

for f in ~/.rbenv/bin/rbenv; do
  if [[ -x $f ]]; then
    eval "$($f init - --no-rehash bash)"
  fi
done
