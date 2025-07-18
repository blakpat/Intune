if (!(Test-Path -Path "C:\GPO_FileShared")) {
    New-Item -Path "C:\GPO_FileShared" -ItemType Directory
}

try {
    cmd.exe /C "cmdkey /add:`"CHANGE_ME`" /user:`"CHANGE_ME`" /pass:`"CHANGE_ME`""
    Add-Content -Path "C:\GPO_FileShared" -Value "$(Get-Date): Clave insertada correctamente para CHANGE_ME"
} catch {
    Add-Content -Path "C:\GPO_FileShared\LogFile.log" -Value "$(Get-Date): ERROR al insertar la clave: $_"
}