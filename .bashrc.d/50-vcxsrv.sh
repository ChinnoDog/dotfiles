#!/bin/bash

# Set up display for VcXsrv if ssh session on Hyper-V/wsl on default internal subnet
VIRT=$(systemd-detect-virt)
if [ "$SESSION_TYPE" == "remote/ssh" ]; then
  if [ "$VIRT" == "microsoft" ] || [ "$VIRT" == "wsl" ]; then
     GW=$(ip route list default | awk '{print $3}')
     if [ "$(echo $GW | cut -f1 -d.)" == "172" ]; then
       export LIBGL_ALWAYS_INDIRECT=1
       export DISPLAY=$GW:0
     fi
  fi
fi
