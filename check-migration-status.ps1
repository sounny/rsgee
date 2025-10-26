#!/usr/bin/env pwsh
# Migration Status Checker
# Shows which pages have been migrated and which are still pending

Write-Host "`n=== Canvas Content Migration Status ===" -ForegroundColor Magenta
Write-Host "Checking content migration progress...`n" -ForegroundColor Cyan

$mapping = @{
    "Week 0 - Welcome" = @(
        @{ file = "modules\week-00-welcome\welcome-to-remote-sensing.html"; name = "Welcome to Remote Sensing" }
        @{ file = "modules\week-00-welcome\earth-engine-api.html"; name = "The Earth Engine API" }
        @{ file = "modules\week-00-welcome\why-javascript.html"; name = "Why JavaScript" }
    )
    "Week 1 - JavaScript Basics" = @(
        @{ file = "modules\week-01-javascript\introduction-to-javascript.html"; name = "Introduction to JavaScript" }
        @{ file = "modules\week-01-javascript\variables.html"; name = "Variables" }
        @{ file = "modules\week-01-javascript\lists.html"; name = "Lists" }
        @{ file = "modules\week-01-javascript\objects.html"; name = "Objects" }
        @{ file = "modules\week-01-javascript\functions.html"; name = "Functions" }
        @{ file = "modules\week-01-javascript\comments.html"; name = "Comments" }
        @{ file = "modules\week-01-javascript\additive-color-system.html"; name = "Additive Color System" }
    )
    "Week 2 - Images & Visualization" = @(
        @{ file = "modules\week-02-images\image-collections.html"; name = "Image Collections" }
        @{ file = "modules\week-02-images\gee-data-catalogs.html"; name = "GEE Data Catalogs" }
        @{ file = "modules\week-02-images\band-arithmetic.html"; name = "Band Arithmetic" }
        @{ file = "modules\week-02-images\spectral-indices.html"; name = "Spectral Indices" }
        @{ file = "modules\week-02-images\ndvi.html"; name = "NDVI" }
    )
    "Week 3 - Classification" = @(
        @{ file = "modules\week-03-classification\introduction-to-image-classification.html"; name = "Intro to Classification" }
        @{ file = "modules\week-03-classification\unsupervised-vs-supervised.html"; name = "Unsupervised vs Supervised" }
        @{ file = "modules\week-03-classification\land-use-vs-land-cover.html"; name = "Land Use vs Cover" }
        @{ file = "modules\week-03-classification\history-of-classification.html"; name = "History of Classification" }
        @{ file = "modules\week-03-classification\unsupervised-classification.html"; name = "Unsupervised Classification" }
    )
}

function Test-PageStatus {
    param([string]$filePath)
    
    if (-not (Test-Path $filePath)) {
        return "MISSING", "Red"
    }
    
    $content = Get-Content $filePath -Raw
    
    if ($content -match "Under Development") {
        return "PLACEHOLDER", "Yellow"
    }
    
    # Check if has substantial content (more than just template)
    if ($content.Length -lt 2000) {
        return "MINIMAL", "Yellow"
    }
    
    return "COMPLETE", "Green"
}

$totalPages = 0
$completedPages = 0
$placeholderPages = 0
$missingPages = 0

foreach ($week in $mapping.Keys | Sort-Object) {
    Write-Host "$week" -ForegroundColor White
    Write-Host ("=" * 60) -ForegroundColor DarkGray
    
    foreach ($page in $mapping[$week]) {
        $totalPages++
        $status, $color = Test-PageStatus $page.file
        
        $icon = switch ($status) {
            "COMPLETE" { "✓"; $completedPages++ }
            "PLACEHOLDER" { "⚠"; $placeholderPages++ }
            "MINIMAL" { "⚡"; $placeholderPages++ }
            "MISSING" { "✗"; $missingPages++ }
        }
        
        $statusText = "[$icon $status]".PadRight(18)
        Write-Host "  $statusText" -ForegroundColor $color -NoNewline
        Write-Host " $($page.name)"
    }
    Write-Host ""
}

# Summary
Write-Host "=== Summary ===" -ForegroundColor Magenta
Write-Host "Total Pages:       $totalPages"
Write-Host "✓ Complete:        " -NoNewline; Write-Host $completedPages -ForegroundColor Green
Write-Host "⚠ Placeholder:     " -NoNewline; Write-Host $placeholderPages -ForegroundColor Yellow
Write-Host "✗ Missing:         " -NoNewline; Write-Host $missingPages -ForegroundColor Red

$percentComplete = [math]::Round(($completedPages / $totalPages) * 100, 1)
Write-Host "`nProgress: $percentComplete% complete" -ForegroundColor Cyan

Write-Host "`n=== Next Steps ===" -ForegroundColor Yellow
if ($missingPages -gt 0 -or $placeholderPages -gt 0) {
    Write-Host "Run migration script to create/update content:"
    Write-Host "  .\migrate-content.ps1 -DryRun  # Preview changes"
    Write-Host "  .\migrate-content.ps1           # Execute migration"
}
else {
    Write-Host "All mapped pages are complete! 🎉"
    Write-Host "Consider:"
    Write-Host "  - Adding more Canvas pages to migration mapping"
    Write-Host "  - Enhancing existing pages with images/diagrams"
    Write-Host "  - Reviewing content for accuracy"
}

Write-Host ""
