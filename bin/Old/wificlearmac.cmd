@echo off
REM Clear the manually provided MAC for the WIFI card
reg delete HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0011 /v NetworkAddress /f
