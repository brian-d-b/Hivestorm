# We will first check for common misconfigurations:

# Check for Windows Defender disabled
$defender_disabled = Get-MpPreference | Select-Object -ExpandProperty DisableRealtimeMonitoring

# Check for Windows Firewall
$firewall_enabled = Get-NetFirewallProfile | Select-Object -ExpandProperty Enabled


# Alert if Windows Defender is disabled
if ($defender_disabled -eq $true) {
    Write-Host "Windows Defender is disabled"
}
# Alert if Windows Firewall is disabled
if ($firewall_enabled -eq $false) {
    Write-Host "Windows Firewall is disabled"
}

# Attempt to start the Windows Defender service
Start-Service -Name WinDefend -ErrorAction SilentlyContinue

# Verify if the service started
$service = Get-Service -Name WinDefend
if ($service.Status -eq 'Running') {
    Write-Host "Windows Defender service is running." -ForegroundColor Green
}
else {
    Write-Host "Failed to start Windows Defender service." -ForegroundColor Red
}
