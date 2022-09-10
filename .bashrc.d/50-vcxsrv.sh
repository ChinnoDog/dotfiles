#!/bin/bash

# Set up display for VcXsrv if
# 1) ssh session on Hyper-V on default internal subnet or
# 2) on wsl
VIRT=$(systemd-detect-virt)
if ([ "$SESSION_TYPE" == "remote/ssh" ] && [ "$VIRT" == "microsoft" ]) || \
   [ "$VIRT" == "wsl" ]; then
  GW=$(ip route list default | awk '{print $3}')
  if [ "$(echo $GW | cut -f1 -d.)" == "172" ]; then
    export LIBGL_ALWAYS_INDIRECT=1
    export DISPLAY=$GW:0
  fi
fi
