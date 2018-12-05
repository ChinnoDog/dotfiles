@ECHO ON
REM Connect to AnyConnect while bypassing the ICS bug

taskkill /f /im vpnui.exe
pushd "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client"
net stop SharedAccess
vpncli connect 66.150.126.1
net start SharedAccess
start vpnui
popd
\\10.100.1.13\software\srnmapdrives.cmd

