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

# Include system default .profile
. /etc/skel/.profile

