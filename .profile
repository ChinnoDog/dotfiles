# Detect ssh session
# https://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
  # many other tests omitted
else
  case $(ps -o comm= -p "$PPID") in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi

if [ -d "$HOME/.profile.d" ]; then
  for i in "$HOME/.profile.d/.profile" "$HOME"/.bashrc.d/*.sh; do
    [ -e "$i" ] || continue # Skip if no matching files
    [ -r "$i" ] && . "$i"
  done
  unset i
fi

