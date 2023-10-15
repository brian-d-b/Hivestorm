# Get a list of all local users
$users = Get-LocalUser

# Get a list of all local groups
$groups = Get-LocalGroup

# Create an array to store the names of empty groups
$emptyGroups = @()

# Output the user information
Write-Host "Users:" -ForegroundColor Green
foreach ($user in $users) {
    Write-Host "User: $($user.Name)"
    Write-Host "Description: $($user.Description)"
    Write-Host "Enabled: $($user.Enabled)"
    Write-Host "Groups:" -ForegroundColor Yellow
    # Determine which groups this user is a member of
    foreach ($group in $groups) {
        if ($group | Get-LocalGroupMember | Where-Object Name -eq $user.Name) {
            Write-Host "   - $($group.Name)"
        }
    }
    Write-Host ""  # Output a blank line between users for readability
}

# Output the group information
Write-Host "Groups:" -ForegroundColor Green
foreach ($group in $groups) {
    $members = $group | Get-LocalGroupMember
    if ($members.Count -gt 0) {
        Write-Host "Group: $($group.Name)"
        Write-Host "Description: $($group.Description)"
        Write-Host "Members:" -ForegroundColor Yellow
        $members | ForEach-Object {
            Write-Host "   - $($_.Name)"
        }
        Write-Host ""  # Output a blank line between groups for readability
    }
    else {
        # Add the name of this empty group to the $emptyGroups array
        $emptyGroups += $group.Name
    }
}

# Output the list of empty groups
Write-Host "Empty Groups:" -ForegroundColor Red
$emptyGroups | ForEach-Object { Write-Host "   - $_" }
