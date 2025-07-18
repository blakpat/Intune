try {
    # Eliminar la clave de cmdkey
    cmd.exe /C "cmdkey /delete:`"CHANGE_ME`""
    $log = "$(Get-Date): Clave eliminada correctamente para CHANGE_ME"
} catch {
    $log = "$(Get-Date): ERROR al eliminar la clave: $_"
}

try {
    # Eliminar la carpeta de logs si existe
    if (Test-Path -Path "C:\GPO_FileShared") {
        Remove-Item -Path "C:\GPO_FileShared" -Recurse -Force
        $log += "`n$(Get-Date): Carpeta de logs C:\GPO_FileShared eliminada correctamente."
    } else {
        $log += "`n$(Get-Date): Carpeta de logs C:\GPO_FileShared no existe."
    }
} catch {
    $log += "`n$(Get-Date): ERROR al eliminar la carpeta de logs: $_"
}

