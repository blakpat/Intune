# URL del archivo .reg (reemplaza con la URL real)
$regUrl = "https://tu_azure_blob_storage/scripts/vpnconfig.reg"

# Ruta local
$folderPath = "C:\PerfilVPN"
$regFile = Join-Path $folderPath "vpnconfig.reg"
$logFile = Join-Path $folderPath "instalacion.log"

# Función para escribir en el log
function Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -FilePath $logFile -Append
    Write-Output $message
}

# Crear carpeta si no existe
if (-not (Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath | Out-Null
    Log "Carpeta $folderPath creada."
}

# Descargar el archivo .reg
try {
    Log "Descargando vpnconfig.reg desde $regUrl..."
    Invoke-WebRequest -Uri $regUrl -OutFile $regFile
    Log "vpnconfig.reg descargado correctamente."
} catch {
    Log "Error al descargar el archivo .reg: $_"
    exit
}

# Importar el archivo .reg usando reg.exe de 64 bits
if (Test-Path $regFile) {
    try {
        $regExe64 = "$env:SystemRoot\SysNative\reg.exe"
        Log "Importando configuración VPN desde $regFile con reg.exe de 64 bits..."
        Start-Process -FilePath $regExe64 -ArgumentList "import `"$regFile`"" -Wait -NoNewWindow
        Log "Importación completada correctamente con reg.exe de 64 bits."
    } catch {
        Log "Error al importar el archivo .reg con reg.exe de 64 bits: $_"
    }
} else {
    Log "El archivo $regFile no se encontró."
}
