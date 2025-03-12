param (
    [string]$Action = "Mount"
)
 
$DriveLetter = "Y"
$NetworkPath = "\\TU_URL\carpeta"
$CredentialTarget = "TU_URL"
$UserName = "localhost\TU_USUARIO"
$Password = "TU_CLAVE"
$LogFile = "C:\2azure\LogFile.log"
 
function Mount-Drive {
    $connectTestResult = Test-NetConnection -ComputerName $CredentialTarget -Port 445
    if ($connectTestResult.TcpTestSucceeded) {
        # Save the password so the drive will persist on reboot
        cmd.exe /C "cmdkey /add:`"$CredentialTarget`" /user:`"$UserName`" /pass:`"$Password`""
       
        # Mount the drive
        New-PSDrive -Name $DriveLetter -PSProvider FileSystem -Root $NetworkPath -Persist
       
        # Log success
        Add-Content -Path $LogFile -Value "$(Get-Date): Drive $DriveLetter mounted successfully."
    } else {
        Write-Error -Message "Unable to reach the network drive via port 445. Check firewall settings."
        Add-Content -Path $LogFile -Value "$(Get-Date): Failed to mount drive $DriveLetter."
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
 
