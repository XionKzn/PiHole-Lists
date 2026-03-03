<#
.SYNOPSIS
  Disable Delivery Optimization (WUDO) via local Group Policy registry settings and stop/disable service.

.DESCRIPTION
  Writes machine policy keys under HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization to disable Delivery Optimization,
  then stops & disables the DoSvc service and forces a group policy update.

.RUNAS
  Run as Administrator.

#>

# Ensure running elevated
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "Script must be run as Administrator."
    exit 1
}

Write-Output "Applying Delivery Optimization Group Policy registry settings..."

$policyKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"

# Create policy key if it doesn't exist
If (-not (Test-Path $policyKey)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "DeliveryOptimization" -Force | Out-Null
}

# Recommended policy values to effectively disable Delivery Optimization:
# - DODownloadMode = 0  (0 = HTTP only; 0 ensures no peer caching; older docs: 0 = HTTP, 100 = bypass)
# - AllowDownloadFromPeers = 0 (disallow from peers)
# - DODownloadMode is the primary setting; set to 0 and disallow peers.
# Also add Enable = 0 to be explicit (some environments use other names)
# Use DWORD values.

New-ItemProperty -Path $policyKey -Name "DODownloadMode" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path $policyKey -Name "AllowDownloadFromPeers" -PropertyType DWord -Value 0 -Force | Out-Null
# Optional explicit keys some templates reference:
New-ItemProperty -Path $policyKey -Name "AllowUploadToPeers" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path $policyKey -Name "Enable" -PropertyType DWord -Value 0 -Force | Out-Null

Write-Output "Registry policy entries written to $policyKey."

# Stop and disable the Delivery Optimization service (DoSvc)
$svcName = "DoSvc"
Try {
    $svc = Get-Service -Name $svcName -ErrorAction Stop
    if ($svc.Status -ne 'Stopped') {
        Write-Output "Stopping service $svcName..."
        Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
    }
    Write-Output "Setting service $svcName startup type to Disabled..."
    Set-Service -Name $svcName -StartupType Disabled
} Catch {
    Write-Warning "Service $svcName not found or error managing service: $_"
}

# Force Group Policy refresh
Write-Output "Forcing Group Policy update..."
gpupdate /force | Out-Null

Write-Output "Done. Delivery Optimization policies set to disabled. Reboot recommended for full effect."
<#
.SYNOPSIS
  Disable Delivery Optimization (WUDO) via local Group Policy registry settings and stop/disable service.

.DESCRIPTION
  Writes machine policy keys under HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization to disable Delivery Optimization,
  then stops & disables the DoSvc service and forces a group policy update.

.RUNAS
  Run as Administrator.

#>

# Ensure running elevated
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "Script must be run as Administrator."
    exit 1
}

Write-Output "Applying Delivery Optimization Group Policy registry settings..."

$policyKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"

# Create policy key if it doesn't exist
If (-not (Test-Path $policyKey)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "DeliveryOptimization" -Force | Out-Null
}

# Recommended policy values to effectively disable Delivery Optimization:
# - DODownloadMode = 0  (0 = HTTP only; 0 ensures no peer caching; older docs: 0 = HTTP, 100 = bypass)
# - AllowDownloadFromPeers = 0 (disallow from peers)
# - DODownloadMode is the primary setting; set to 0 and disallow peers.
# Also add Enable = 0 to be explicit (some environments use other names)
# Use DWORD values.

New-ItemProperty -Path $policyKey -Name "DODownloadMode" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path $policyKey -Name "AllowDownloadFromPeers" -PropertyType DWord -Value 0 -Force | Out-Null
# Optional explicit keys some templates reference:
New-ItemProperty -Path $policyKey -Name "AllowUploadToPeers" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path $policyKey -Name "Enable" -PropertyType DWord -Value 0 -Force | Out-Null

Write-Output "Registry policy entries written to $policyKey."

# Stop and disable the Delivery Optimization service (DoSvc)
$svcName = "DoSvc"
Try {
    $svc = Get-Service -Name $svcName -ErrorAction Stop
    if ($svc.Status -ne 'Stopped') {
        Write-Output "Stopping service $svcName..."
        Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
    }
    Write-Output "Setting service $svcName startup type to Disabled..."
    Set-Service -Name $svcName -StartupType Disabled
} Catch {
    Write-Warning "Service $svcName not found or error managing service: $_"
}

# Force Group Policy refresh
Write-Output "Forcing Group Policy update..."
gpupdate /force | Out-Null

Write-Output "Done. Delivery Optimization policies set to disabled. Reboot recommended for full effect."
