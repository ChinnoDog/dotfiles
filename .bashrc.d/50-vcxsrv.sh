#!/bin/bash

# Set up display for VcXsrv if
# 1) ssh session on Hyper-V on default internal subnet or
# 2) on wsl
VIRT=$(systemd-detect-virt)
if ([ "$SESSION_TYPE" == "remote/ssh" ] && [ "$VIRT" == "microsoft" ]) || \
   [ "$VIRT" == "wsl" ]; then
  GW=$(ip route list default | awk '{print $3}')
  CLSA=$(echo $GW | cut -f1 -d.)
  if [ "$CLSA" == "172" ]; then
    GWDIG=$(dig +short -x $GW)
    GWHOST=${GWDIG::-1}
    export DISPLAY=$GWHOST:0
  elif [ "$CLSA" == "192" ]; then
    export DISPLAY=$USER.lan:0
  fi
  export LIBGL_ALWAYS_INDIRECT=1
fi
