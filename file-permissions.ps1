# Define the root directory you want to start from
$rootDirectory = "C:\Test\Path"

# Get all subdirectories under the root directory, including nested subdirectories
$directories = Get-ChildItem -Path $rootDirectory -Recurse -Directory

# Iterate through each subdirectory
foreach ($directory in $directories) {
    # Get the access control list (ACL) for the current subdirectory
    $acl = Get-Acl -Path $directory.FullName
    
    # Format the ACL information as a list and output it to the console
    Write-Output $acl | Format-List
}
