# Move Lab images referenced from Canvas export to images/canvas/ and rewrite lab HTML paths
param(
    [string]$RepoRoot = 'c:\Users\sounn\Git\rsgee',
    [string]$LabsDir = 'labs',
    [string]$CanvasResources = 'tobeworkedon\\web_resources',
    [string]$ImagesSubdir = 'images\\canvas',
    [int[]]$Labs = @(11,12,13,14,15,16,17,18,19,20),
    [switch]$WhatIf
)

$ErrorActionPreference = 'Stop'
$labsPath = Join-Path $RepoRoot $LabsDir
$srcBase = Join-Path $RepoRoot $CanvasResources
$destBase = Join-Path $RepoRoot $ImagesSubdir

if (-not (Test-Path $destBase)) { New-Item -ItemType Directory -Path $destBase | Out-Null }

# Build list of lab html files to process
$labFiles = @()
foreach ($n in $Labs) {
    $name = "lab-{0:D2}" -f $n
    $file = Get-ChildItem -Path $labsPath -Filter "$name*" -File | Select-Object -First 1
    if ($file) { $labFiles += $file.FullName }
}

Write-Host ("Processing {0} lab files" -f $labFiles.Count) -ForegroundColor Cyan

# Regex to match src="../tobeworkedon/web_resources/..."
$pattern = 'src=\"\.\./tobeworkedon/web_resources/([^\"]+)\"'

foreach ($labFile in $labFiles) {
    $relUpdated = 0
    $content = Get-Content $labFile -Raw -Encoding UTF8
    $imgMatches = [regex]::Matches($content, $pattern)
    if ($imgMatches.Count -eq 0) { continue }

    foreach ($m in $imgMatches) {
    $relPath = $m.Groups[1].Value  # URL-encoded path under web_resources
    $relPathDecoded = [System.Uri]::UnescapeDataString($relPath)
    $relPathDecodedFs = ($relPathDecoded -replace '/', '\\')
    $srcPath = Join-Path $srcBase $relPathDecodedFs
    $destPath = Join-Path $destBase $relPathDecodedFs
        $destDir = Split-Path $destPath -Parent
        if (-not (Test-Path $destDir)) {
            if ($WhatIf) {
                Write-Host "[WHATIF] Would create directory: $destDir" -ForegroundColor Yellow
            } else {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
        }
        if (Test-Path $srcPath) {
            if ($WhatIf) {
                Write-Host "[WHATIF] Would copy: $srcPath -> $destPath" -ForegroundColor Yellow
            } else {
                Copy-Item -Path $srcPath -Destination $destPath -Force
            }
            # Update content src to ../images/canvas/<relPath>
            $safeRel = ($relPath -replace '\\','/')
            $newSrc = ('src="../images/canvas/{0}"' -f $safeRel)
            $content = $content.Replace($m.Value, $newSrc)
            $relUpdated++
        } else {
            Write-Host "WARNING: Source not found: $srcPath (referenced in $labFile)" -ForegroundColor Red
        }
    }

    if ($relUpdated -gt 0) {
        if ($WhatIf) {
            Write-Host "[WHATIF] Would update: $labFile ($relUpdated replacements)" -ForegroundColor Yellow
        } else {
            $content | Out-File -FilePath $labFile -Encoding UTF8
            Write-Host "Updated: $labFile ($relUpdated replacements)" -ForegroundColor Green
        }
    }
}

Write-Host "Done. Images copied to $destBase and lab HTML updated." -ForegroundColor Green
