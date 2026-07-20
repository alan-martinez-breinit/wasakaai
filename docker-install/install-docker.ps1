<#
.SYNOPSIS
    Instalación automatizada de Docker Desktop para Windows 11 Pro
    Generado por WasakaAI — 24/06/2026
.NOTES
    Ejecutar como ADMINISTRADOR.
    Botón derecho > "Ejecutar con PowerShell como administrador"
#>

$ErrorActionPreference = "Stop"
$logFile = "$env:USERPROFILE\WasakaAI\docker-install\install-log.txt"

function Write-Log {
    param([string]$Message)
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $Message"
    Write-Host $line -ForegroundColor Cyan
    Add-Content -Path $logFile -Value $line
}

function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($id)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# ---- PREFLIGHT ----
if (-not (Test-Admin)) {
    Write-Host "ERROR: Este script debe ejecutarse como ADMINISTRADOR." -ForegroundColor Red
    Write-Host "Cierra esta ventana y usa: Boton derecho > Ejecutar como administrador" -ForegroundColor Yellow
    exit 1
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "  DOCKER DESKTOP - Instalacion Automatica" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Log "Iniciando instalacion..."

# ---- PASO 1: Habilitar WSL2 ----
Write-Log "[1/5] Habilitando Windows Subsystem for Linux (WSL)..."
dism /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart | Out-Null
Write-Log "  WSL habilitado."

# ---- PASO 2: Habilitar Virtual Machine Platform ----
Write-Log "[2/5] Habilitando Virtual Machine Platform..."
dism /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart | Out-Null
Write-Log "  Virtual Machine Platform habilitada."

# ---- PASO 3: Instalar/actualizar WSL kernel ----
Write-Log "[3/5] Instalando actualizacion de WSL..."
wsl --update
wsl --set-default-version 2
Write-Log "  WSL actualizado y configurado a WSL2."

# ---- PASO 4: Instalar Docker Desktop ----
Write-Log "[4/5] Instalando Docker Desktop..."
$installer = "$env:USERPROFILE\WasakaAI\docker-install\DockerDesktopInstaller.exe"

if (-not (Test-Path $installer)) {
    Write-Log "  ERROR: No se encuentra el instalador en $installer"
    exit 1
}

Write-Log "  Ejecutando instalador (esto puede tomar varios minutos)..."
Start-Process -FilePath $installer -ArgumentList "install --accept-license --quiet" -Wait -NoNewWindow
Write-Log "  Instalador completado."

# ---- PASO 5: Verificacion ----
Write-Log "[5/5] Verificando instalacion..."
Start-Sleep -Seconds 10

# Esperar a que el servicio Docker arranque
$maxRetries = 30
$retryCount = 0
$dockerStarted = $false

while ($retryCount -lt $maxRetries -and -not $dockerStarted) {
    $svc = Get-Service -Name "com.docker.service" -ErrorAction SilentlyContinue
    if ($svc -and $svc.Status -eq "Running") {
        $dockerStarted = $true
        Write-Log "  Servicio Docker en ejecucion."
    } else {
        $retryCount++
        Start-Sleep -Seconds 5
    }
}

if ($dockerStarted) {
    Write-Log "  Docker Desktop instalado y funcionando."
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  INSTALACION COMPLETADA CON EXITO" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  SUGERENCIA: Ejecuta 'docker run hello-world'" -ForegroundColor Yellow
    Write-Host "  en una terminal NORMAL (no admin) para probarlo." -ForegroundColor Yellow
} else {
    Write-Log "  El servicio Docker no arranco automaticamente."
    Write-Log "  Prueba reiniciando el equipo o iniciando Docker Desktop manualmente."
}

Write-Log "Log guardado en: $logFile"
