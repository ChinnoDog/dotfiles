# System default .bashrc
. /etc/skel/.bashrc

# Execute .bashrc.d scripts
if [ -d ~/.bashrc.d ]; then
  for i in ~/.bashrc.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

