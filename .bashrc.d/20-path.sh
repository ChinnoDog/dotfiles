#!/bin/sh
# Construct and export $PATH

prepend_to_path() {
  case ":$PATH:" in
    *":$1:"*) ;;  # already present
    *) PATH="$1:$PATH" ;;
  esac
}

append_to_path() {
  case ":$PATH:" in
    *":$1:"*) ;;  # already present
    *) PATH="$PATH:$1" ;;
  esac
}

prepend_to_path "$HOME/.local/bin"
prepend_to_path "$HOME/bin"
