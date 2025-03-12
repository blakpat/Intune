$connectTestResult = Test-NetConnection -ComputerName TU_URL -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"TU_URL`" /user:`"localhost\TU_USUARIO`" /pass:`"TU_CLAVE`""
    # Mount the drive
    New-PSDrive -Name Y -PSProvider FileSystem -Root "\\TU_URL\carpeta" -Persist
    # Log success
    Add-Content -Path "C:\2azure\LogFile.log" -Value "$(Get-Date): Drive Y mounted successfully."
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
    # Log failure
    Add-Content -Path "C:\2azure\LogFile.log" -Value "$(Get-Date): Failed to mount drive W."