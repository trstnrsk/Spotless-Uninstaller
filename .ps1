# STEP 1: Get the most recent uninstall event from the Event Log
$lastUninstallEvent = Get-WinEvent -LogName "Application" |
    Where-Object {
        $_.ProviderName -eq "MsiInstaller" -and
        $_.Id -eq 1034
    } |
    Sort-Object TimeCreated -Descending |
    Select-Object -First 1

if (-not $lastUninstallEvent) {
    Write-Host "No recent uninstall event found."
    exit
}

# STEP 2: Extract the product name from the event message
$productName = ($lastUninstallEvent.Message -split "`n") |
    Where-Object { $_ -like "*Product Name*" } |
    ForEach-Object { ($_ -split ":")[1].Trim() }

if (-not $productName) {
    Write-Host "Failed to extract product name from event log."
    exit
}

Write-Host "Last uninstalled software: $productName"

# STEP 3: Construct path to user's AppData\Local
$appDataLocal = Join-Path $env:LOCALAPPDATA ""

# STEP 4: Find matching folders
$matchingFolders = Get-ChildItem -Path $appDataLocal -Directory |
    Where-Object { $_.Name -like "*$($productName)*" }

if ($matchingFolders.Count -eq 0) {
    Write-Host "No folders in AppData\Local matched the product name."
    exit
}

# STEP 5: Delete matching folders
foreach ($folder in $matchingFolders) {
    try {
        Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction Stop
        Write-Host "Deleted: $($folder.FullName)"
    } catch {
        Write-Warning "Failed to delete: $($folder.FullName) - $_"
    }
}