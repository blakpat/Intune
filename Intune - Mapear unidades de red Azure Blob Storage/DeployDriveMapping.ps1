param (
    [string]$Action = "Mount"
)

$DriveLetter = "G"
$NetworkPath = "\\tu_url"
$UserName = "tu_usuario"
$Password = "tu_passowrd"
$LogFile = "C:\2azure\LogFile.log"

function Mount-Drive {
    $connectTestResult = Test-NetConnection -ComputerName "tu_url" -Port 445
    if ($connectTestResult.TcpTestSucceeded) {
        # Montar la unidad usando net use (más persistente)
        cmd.exe /C "net use ${DriveLetter}: ${NetworkPath} ${Password} /USER:${UserName} /PERSISTENT:YES"
        
        # Log success
        Add-Content -Path $LogFile -Value "$(Get-Date): Drive ${DriveLetter} mounted successfully."
    } else {
        Write-Error -Message "Unable to reach the network drive via port 445. Check firewall settings."
        Add-Content -Path $LogFile -Value "$(Get-Date): Failed to mount drive ${DriveLetter}."
    }
}

function Unmount-Drive {
    # Desmontar la unidad
    cmd.exe /C "net use ${DriveLetter}: /delete /yes"

    # Log success
    Add-Content -Path $LogFile -Value "$(Get-Date): Drive ${DriveLetter} unmounted successfully."
}

if ($Action -eq "Mount") {
    Mount-Drive
} elseif ($Action -eq "Unmount") {
    Unmount-Drive
} else {
    Write-Error -Message "Invalid action specified. Use 'Mount' or 'Unmount'."
}
