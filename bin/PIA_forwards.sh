#!/bin/sh
USERNAME=
PASSWORD=
LOCAL_IP=$(nmcli con status id "$(nmcli -f name con status | grep 'PIA' | xargs)" | grep 'ip_address' | xargs | cut -f 4 -d ' ')

#echo $(cat ~/.pia_client_id)
#echo $LOCAL_IP
curl -d "user=$USERNAME&pass=$PASSWORD&client_id=$(cat ~/.pia_client_id)&local_ip=$LOCAL_IP" https://www.privateinternetaccess.com/vpninfo/port_forward_assignment
