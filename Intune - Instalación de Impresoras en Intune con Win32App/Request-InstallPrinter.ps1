# Parámetros de configuración del Azure Blob Storage
$blobBaseUrl = "https://tu_repo_en_azure/printerdriver"  # Cambia esto con tu URL base
$filesToDownload = @(
    "cnp60m.cat", 
    "CNP60MA64.INF", 
    "gppcl6.cab", 
    "Install-Printer.ps1", 
    "Remove-Printer.ps1"
)

# Definir carpeta en C:\ en lugar de TEMP
$tempDir = "C:\PrinterInstall\PL0-BN"
if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Force -Path $tempDir
}

# Descargar los archivos desde el Blob
foreach ($file in $filesToDownload) {
    $fileUrl = "$blobBaseUrl/$file"
    $destinationPath = [System.IO.Path]::Combine($tempDir, $file)
    
    Write-Host "Descargando $file a $destinationPath"
    
    # Descargar el archivo desde la URL pública
    Invoke-WebRequest -Uri $fileUrl -OutFile $destinationPath
}

# Ejecutar el script de instalación de la impresora
$installPrinterScript = [System.IO.Path]::Combine($tempDir, "Install-Printer.ps1")

# Verificar si el script de instalación existe antes de ejecutarlo
if (Test-Path $installPrinterScript) {
    Write-Host "Ejecutando script de instalación de la impresora..."
    powershell.exe -ExecutionPolicy Bypass -File $installPrinterScript -PortName "IP_192.1.1.5" -PrinterIP "192.1.1.5" -PrinterName "Canon B/N Administracion Planta 0" -DriverName "Canon Generic Plus PCL6" -INFFile "CNP60MA64.inf"
} else {
    Write-Host "El script de instalación no se encontró."
}

# Eliminar los archivos temporales si lo deseas
# Remove-Item -Path $tempDir -Recurse -Force
