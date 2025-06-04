# Enable direnv only if the command exists
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

