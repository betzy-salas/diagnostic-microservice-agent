# Instala (o desinstala) Agente Q para GitHub Copilot a nivel de usuario.
# Uso (PowerShell):
#   .\install.ps1              Instala o actualiza
#   .\install.ps1 -Uninstall   Elimina los agentes y skills de Agente Q
# Si PowerShell bloquea el script:
#   powershell -ExecutionPolicy Bypass -File .\install.ps1

param(
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'

$KitDir     = $PSScriptRoot
$CopilotDir = Join-Path $HOME '.copilot'
$AgentsDir  = Join-Path $CopilotDir 'agents'
$SkillsDir  = Join-Path $CopilotDir 'skills'

$KitAgents = Get-ChildItem -Path (Join-Path $KitDir 'agents') -Filter '*.agent.md' -File
$KitSkills = Get-ChildItem -Path (Join-Path $KitDir 'skills') -Directory

if ($Uninstall) {
    Write-Host 'Desinstalando Agente Q...'
    foreach ($f in $KitAgents) {
        $target = Join-Path $AgentsDir $f.Name
        if (Test-Path $target) { Remove-Item $target -Force; Write-Host "  eliminado: $target" }
    }
    foreach ($d in $KitSkills) {
        $target = Join-Path $SkillsDir $d.Name
        if (Test-Path $target) { Remove-Item $target -Recurse -Force; Write-Host "  eliminado: $target" }
    }
    Write-Host 'Listo. Recarga VS Code (Developer: Reload Window).'
    exit 0
}

# Si ~/.copilot/agents es un repositorio clonado (agente anterior), no se instala encima.
if (Test-Path (Join-Path $AgentsDir '.git')) {
    Write-Host "ERROR: $AgentsDir es un clon de Git (agente anterior)." -ForegroundColor Red
    Write-Host 'Renómbralo y vuelve a ejecutar este script, por ejemplo:'
    Write-Host "  Rename-Item `"$AgentsDir`" 'agents-old'"
    exit 1
}

New-Item -ItemType Directory -Force -Path $AgentsDir | Out-Null
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

$VersionFile = Join-Path $KitDir 'VERSION'
$Version = if (Test-Path $VersionFile) { (Get-Content $VersionFile -Raw).Trim() } else { 'desconocida' }
Write-Host 'Agente Q - con licencia para evolucionar'
Write-Host "Kit: $KitDir"
Write-Host "Versión: $Version"

Write-Host "Instalando agentes en $AgentsDir..."
foreach ($f in $KitAgents) {
    Copy-Item $f.FullName -Destination $AgentsDir -Force
    Write-Host "  $($f.Name)"
}

Write-Host "Instalando skills en $SkillsDir..."
foreach ($d in $KitSkills) {
    $target = Join-Path $SkillsDir $d.Name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    Copy-Item $d.FullName -Destination $target -Recurse -Force
    Write-Host "  $($d.Name)"
}

Write-Host ''
Write-Host 'Instalación completa. En VS Code ejecuta: Developer: Reload Window' -ForegroundColor Green
