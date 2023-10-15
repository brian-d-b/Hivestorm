# Get a list of all processes
$processes = Get-Process

# Loop through each process
foreach ($process in $processes) {
    # Get process owner information
    $owner = (Get-WmiObject -Class Win32_Process -Filter "ProcessId=$($process.Id)").GetOwner().User

    # Get the process executable path
    $path = (Get-WmiObject -Class Win32_Process -Filter "ProcessId=$($process.Id)").ExecutablePath
    
    # Get the services associated with this process (lol this is slow but it gets the job done)
    $services = $process | Get-Service -ErrorAction SilentlyContinue
    
    # Output the information
    Write-Host "Process Name: $($process.Name)"
    Write-Host "Process ID: $($process.Id)"
    Write-Host "Owner: $owner"
    Write-Host "Path: $path"
    Write-Host "Services: $($services -join ', ')"
    Write-Host "---------------------------------------"
}
