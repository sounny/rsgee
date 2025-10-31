# Organize images from Canvas export into appropriate content-specific directories
param(
    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSCommandPath
$uploadedMedia = Join-Path $repoRoot 'tobeworkedon\web_resources\Uploaded Media'

# Define image mappings by date pattern to content series
$imageMappings = @{
    # River Morphology (October 26, November 2)
    'Screenshot 2023-10-26*.png' = 'images\river-morphology'
    'Screenshot 2023-11-02*.png' = 'images\river-morphology'
    
    # Global Snow Observatory (need to identify - likely Feb/March/April)
    'Screenshot 2023-01-*.png' = 'images\global-snow'
    'Screenshot 2023-02-*.png' = 'images\global-snow'
    'Screenshot 2023-03-*.png' = 'images\global-snow'
    'Screenshot 2023-04-*.png' = 'images\global-snow'
    'AddDate.png' = 'images\global-snow'
    'BlackMap.png' = 'images\global-snow'
    'Mask.png' = 'images\global-snow'
    'MaskSnesor.png' = 'images\global-snow'
    'MaksForm.png' = 'images\global-snow'
    'FinalMapCall.png' = 'images\global-snow'
    'LookupTable.png' = 'images\global-snow'
    'LinFit.png' = 'images\global-snow'
    'Reclass.png' = 'images\global-snow'
    
    # Heat Islands (November 9)
    'Screenshot 2023-11-09*.png' = 'images\heat-islands'
    
    # Fire (November 16)
    'Screenshot 2023-11-16*.png' = 'images\fire'
    
    # Fire-related named files
    '*obcat*.jpg' = 'images\fire'
    '*obcat*.webp' = 'images\fire'
    'LDN-L-BOBCATFIRE*.webp' = 'images\fire'
    'Napa_Fire*.webp' = 'images\fire'
    '200921003037*.jpg' = 'images\fire'
    
    # General diagrams
    '*diagram*.png' = 'images\diagrams'
    '*diagram*.jpg' = 'images\diagrams'
    'figure2.webp' = 'images\diagrams'
    'angles.gif' = 'images\diagrams'
    
    # NDVI and classification images
    '*ndvi*.png' = 'images\diagrams'
    '*NDVI*.gif' = 'images\diagrams'
    '*classification*.jpg' = 'images\diagrams'
    'supervised-diagram.png' = 'images\diagrams'
    'unsupervised-diagram.png' = 'images\diagrams'
    
    # Landsat and sensor info
    '*landsat*.png' = 'images\diagrams'
    '*Landsat*.jpg' = 'images\diagrams'
    
    # MODIS images
    'MOD*.png' = 'images\diagrams'
    
    # Animation files
    '*.gif' = 'images\animations'
    
    # Plant/tree reference images
    'plants.jpg.webp' = 'images\diagrams'
    'tree.jpg.webp' = 'images\diagrams'
    'p9p1-lg-1.jpg' = 'images\diagrams'
    
    # Capture files (likely screenshots from early development)
    'Capture*.png' = 'images\screenshots'
    'Capture*.JPG' = 'images\screenshots'
    
    # Remote sensing overview images
    'Remote Sensing*.png' = 'images\diagrams'
    
    # Misc images
    'SCFgraph*.png' = 'images\diagrams'
    'image35.png' = 'images\diagrams'
}

function New-DirIfMissing([string]$path) {
    if (-not (Test-Path -LiteralPath $path)) {
        if ($WhatIf) {
            Write-Host "[WHATIF] Would create directory: $path" -ForegroundColor Cyan
        } else {
            New-Item -ItemType Directory -Path $path -Force | Out-Null
            Write-Host "Created directory: $path" -ForegroundColor Green
        }
    }
}

# Track which files have been processed
$processedFiles = @{}

Write-Host "Organizing images from Canvas export..." -ForegroundColor Yellow
Write-Host "Source: $uploadedMedia" -ForegroundColor Gray
Write-Host ""

foreach ($pattern in $imageMappings.Keys) {
    $destDir = Join-Path $repoRoot $imageMappings[$pattern]
    
    $files = @(Get-ChildItem -Path $uploadedMedia -Filter $pattern -File -ErrorAction SilentlyContinue)
    
    if ($files.Count -eq 0) { continue }
    
    New-DirIfMissing -path $destDir
    
    foreach ($file in $files) {
        # Skip if already processed by a previous pattern
        if ($processedFiles.ContainsKey($file.Name)) {
            continue
        }
        
        $processedFiles[$file.Name] = $true
        $destPath = Join-Path $destDir $file.Name
        
        if ($WhatIf) {
            Write-Host "[WHATIF] $($file.Name) -> $($imageMappings[$pattern])" -ForegroundColor Cyan
        } else {
            Copy-Item -LiteralPath $file.FullName -Destination $destPath -Force
            Write-Host "Copied: $($file.Name) -> $($imageMappings[$pattern])" -ForegroundColor Green
        }
    }
}

# Report any remaining files not matched
Write-Host ""
Write-Host "Checking for unprocessed files..." -ForegroundColor Yellow
$allFiles = Get-ChildItem -Path $uploadedMedia -File
$unprocessed = $allFiles | Where-Object { -not $processedFiles.ContainsKey($_.Name) -and $_.Extension -match '\.(png|jpg|jpeg|gif|webp)$' }

if ($unprocessed.Count -gt 0) {
    Write-Host "Found $($unprocessed.Count) unprocessed image files:" -ForegroundColor Yellow
    foreach ($file in $unprocessed) {
        Write-Host "  - $($file.Name)" -ForegroundColor Gray
    }
} else {
    Write-Host "All image files have been processed!" -ForegroundColor Green
}

Write-Host ""
if ($WhatIf) {
    Write-Host "Done (preview mode). Re-run without -WhatIf to copy files." -ForegroundColor Cyan
} else {
    Write-Host "Done! Images have been organized into content-specific directories." -ForegroundColor Green
    Write-Host "Next step: Update HTML files to reference new image paths." -ForegroundColor Yellow
}
