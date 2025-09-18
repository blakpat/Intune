#1)Instalar Kubectl y certificado de conexión Azure AKS
#1.1)Modifica la URL por la ruta donde tengas almacenado los archivos siguientes:
#K9S.exe
#Kubectl.exe
#Archivo de conexión AKS

$baseUrl = "https://CHANGE.ME/Kubernetes"
$kubeDir = "$env:USERPROFILE\.kube\"
$system32 = "$env:windir\SysNative"
$errorMsg = ""
$success = $true
 
try {
    # Crea el directorio
    if (-not (Test-Path -Path $kubeDir)) {
        New-Item -ItemType Directory -Path $kubeDir -Force | Out-Null
    }

    # Descargar config donde estan lo archivos
    $configUrl = "$baseUrl/config"
    $configDest = "$kubeDir\config"
    Write-Host "Descargando config desde $configUrl ..."
    Invoke-WebRequest -Uri $configUrl -OutFile $configDest

    # Descargar los .exe a una carpeta temporal
    $tempDir = [System.IO.Path]::GetTempPath()
    $executables = @("kubectl.exe", "k9s.exe")
    foreach ($exe in $executables) {
        $exeUrl = "$baseUrl/$exe"
        $tempExePath = "$tempDir\$exe"
        Write-Host "Descargando $exe desde $exeUrl ..."
        Invoke-WebRequest -Uri $exeUrl -OutFile $tempExePath

        # Copiar a System32
        $destExePath = "$system32\$exe"
        Write-Host "Copiando $exe a $destExePath ..."
        Copy-Item -Path $tempExePath -Destination $destExePath -Force
    }

    Write-Host "¡Descarga y copia completadas!"
}
catch {
    $success = $false
    $errorMsg = $_.Exception.Message
    Write-Host "Error: $errorMsg"
}
