@echo off
pushd %0\..
call .\wifigenrandmac.cmd
reg add HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0011 /v NetworkAddress /t REG_SZ /d %wifirandmac%
popd