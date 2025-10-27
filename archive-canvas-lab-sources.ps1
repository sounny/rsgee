# Archive Canvas lab source folders (Labs 11–20) into a dated folder under tobeworkedon/_archived_labs-YYYY-MM-DD
param(
    [string[]]$LabFolders = @(
        'g47a41cb339f8b59a160477fbb679c215', # Lab 11
        'g83abe5fda48df9ea87a413be856dc7f6', # Lab 12
        'gd9a036d4cbd478902226e0b0487b2d50', # Lab 13
        'g0a9b6e6593a3bd34a339b34b7328a8e2', # Lab 14
        'g33105de7dace79d610798ae5f8e24afa', # Lab 15
        'g3caf98f66d8f06f0d2a58ee130a9b65d', # Lab 16
        'g8b69574c3631ed2978f1e66c185820ee', # Lab 17
        'g51c9a193ca3bbb21598af5e9c7f3153e', # Lab 18
        'g33a00968ab4466635f79ebf7e711f9a9', # Lab 19
        'g6ab6b645e8e2c513896f3ecf1a96c1a9'  # Lab 20
    ),
    [string]$CanvasRoot = 'c:\Users\sounn\Git\rsgee\tobeworkedon'
)

$stamp = Get-Date -Format 'yyyy-MM-dd'
$dest = Join-Path $CanvasRoot ("_archived_labs_" + $stamp)
if (-not (Test-Path $dest)) {
    New-Item -ItemType Directory -Path $dest | Out-Null
}

foreach ($id in $LabFolders) {
    $src = Join-Path $CanvasRoot $id
    if (Test-Path $src) {
        Write-Host "Archiving $id ..." -ForegroundColor Cyan
        Move-Item -Path $src -Destination $dest -Force
    } else {
        Write-Host "Skipping $id (not found)" -ForegroundColor Yellow
    }
}

Write-Host "Done. Archived to: $dest" -ForegroundColor Green
