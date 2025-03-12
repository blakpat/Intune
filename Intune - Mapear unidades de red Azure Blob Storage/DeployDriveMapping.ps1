param (
    [string]$Action = "Mount"
)

$DriveLetter = "Y"
$NetworkPath = "\\URL_BLOB_STARAGE\folder"
$UserName = "localhost\USER"
$Password = "PASSWORD"
$LogFile = "C:\2azure\LogFile.log"

function Mount-Drive {
    # Montar la unidad usando net use 
    cmd.exe /C "net use ${DriveLetter}: ${NetworkPath} ${Password} /USER:${UserName} /PERSISTENT:YES"
    
    # Log success
    Add-Content -Path $LogFile -Value "$(Get-Date): Drive ${DriveLetter} mounted successfully."
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
