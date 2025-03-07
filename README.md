# 📄 Instalación de Impresoras en Intune con Win32App en entornos entra ID
Intune Proyects
📄 Instalación de Impresoras en Intune con Win32App en entornos entra ID


Este procedimiento detalla la instalación de impresoras de red utilizando Microsoft Intune Win32App y PowerShell.

🔗 Referencia Instalar impresoras en Intune con Win32Apps y PowerShell

📌 Componentes Principales

📂 Drivers de la Impresora para Canon Universal Print Driver PLC6

•	cnp60m.cat → Archivos necesario

•	CNP60MA64.INF → Archivo de que contiene la información del Driver

•	GPPCL6.cab → Archivos necesario


📂 Scripts

•	Install-Printer.ps1 → Instala la impresora y el driver.

•	Remove-Printer.ps1 → Elimina la impresora.

•	Request-InstallPrinter.ps1 → Script principal creado por mi para el despliegue


 📖 Funcionalidades del Script Request-InstallPrinter.ps1:
 
🔹 Parámetros de configuración del Azure Blob Storage

🔹 Definir carpeta en C:\

🔹 Descargar los archivos desde el Blob

🔹 Descargar el archivo desde la URL pública

🔹 Ejecutar el script de instalación de la impresora Install-Printer.ps1 con los parámetros pasados

🔹 Verificar si el script de instalación existe antes de ejecutarlo


📂 Paquete Win32 para Intune

•	Request-InstallPrinter.intunewin

•	IntuneWinAppUtil.exe → Herramienta para empaquetar scripts.

🛠️ ¿Cómo funciona?

1️⃣ Configurar el Script

Para añadir nuevas impresoras, edita el archivo Request-InstallPrinter.ps1 y ajusta:

🔹 URL: Define la ubicación de descarga de los archivos.  

🔹 PATH: Ruta donde se guardarán los archivos descargados de Azure en el cliente.

 

🔹 IMPRESORAS: Modifica la línea donde se ejecuta Install-Printer.ps1, indicando:

•	IP de la impresora

•	IP del puerto

•	Nombre del controlador (consultable en el .INF)

•	Nombre de la impresora


2️⃣ Empaquetar el Script  Request-InstallPrinter.ps1 en Formato IntuneWin

Ejecuta IntuneWinAppUtil.exe desde la línea de comandos (CMD) y proporciona:

•	Ruta de la carpeta que contiene el script.

•	Nombre del script (Request-InstallPrinter.ps1).

•	Ruta de destino para generar el archivo .intunewin.


 
3️⃣ Subir los archivos al Blob Storage

Asegúrate de cargar los siguientes archivos:

✅ cnp60m.cat

✅ CNP60MA64.INF

✅ GPPCL6.cab

✅ Install-Printer.ps1

✅ Remove-Printer.ps1

4️⃣ Crear la aplicación Win32 en Intune

📌 Sección Aplicaciones

•	Tipo de aplicación: Aplicación de Windows (Win32)

•	Subir el archivo .intunewin.

•	Completar los campos: Nombre, Descripción, Publicador y Logo.

📌 Sección Programa

•	Comando de instalación: powershell.exe -ExecutionPolicy Bypass -File Request-InstallPrinter.ps1

•	Comando de desinstalación: powershell.exe -ExecutionPolicy Bypass -File C:\PrinterInstall\PL0-BN\Remove-Printer.ps1 -PrinterName "Canon B/N Administracion Planta 0"
•	Permitir desinstalación: ✅ Sí

•	Comportamiento de reinicio: Ninguna acción específica


📌 Sección Requisitos

Completar los campos obligatorios según el entorno.

📌 Sección Detección

•	Regla de detección: Archivo

•	Ruta: C:\PrinterInstall

•	Archivo o carpeta: PL1-BN (Pon lo que tú quieras siempre que este el contenido en la ruta)

•	Método de detección: El archivo o carpeta existe

•	Asociado a una app de 32 bits en clientes de 64 bits: ❌ No

📌 Sección Asignación

Asignar la aplicación a los usuarios o dispositivos necesarios.

✅ Finalización
 




