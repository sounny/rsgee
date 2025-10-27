# Move images referenced in module pages (week-*) from Canvas export to images/canvas and rewrite HTML src paths
param(
    [string]$CanvasResources = 'tobeworkedon\web_resources',
    [string]$ImagesCanvas = 'images\canvas',
    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function New-DirIfMissing([string]$path) {
    if (-not (Test-Path -LiteralPath $path)) {
        if ($WhatIf) {
            Write-Host "[WHATIF] Would create directory: $path"
        } else {
            New-Item -ItemType Directory -Path $path | Out-Null
        }
    }
}

# Collect module HTML files under week-* directories
$repoRoot = Split-Path -Parent $PSCommandPath
$weekDirs = Get-ChildItem -LiteralPath $repoRoot -Directory -Filter 'week-*' | Select-Object -ExpandProperty FullName
$files = @()
foreach ($dir in $weekDirs) {
    $files += Get-ChildItem -LiteralPath $dir -Filter '*.html' -File -Recurse | Select-Object -ExpandProperty FullName
}

if ($files.Count -eq 0) {
    Write-Host 'No module HTML files found under week-* directories.'
    return
}

Write-Host ("Processing {0} module files" -f $files.Count)

# Match src="../../tobeworkedon/web_resources/<rel>"
$pattern = 'src="\.\./\.\./tobeworkedon/web_resources/([^"]+)"'

foreach ($file in $files) {
    $html = [System.IO.File]::ReadAllText($file)
    $imgMatches = [System.Text.RegularExpressions.Regex]::Matches($html, $pattern)
    if ($imgMatches.Count -eq 0) { continue }

    foreach ($m in $imgMatches) {
        $relEncoded = $m.Groups[1].Value  # Keep encoded for HTML rewrite
    # Decode for filesystem path (use Uri Unescape to avoid System.Web dependency)
    $relDecoded = [System.Uri]::UnescapeDataString($relEncoded)

        $srcPath = Join-Path -Path $repoRoot -ChildPath (Join-Path -Path $CanvasResources -ChildPath $relDecoded)
        $destPath = Join-Path -Path $repoRoot -ChildPath (Join-Path -Path $ImagesCanvas -ChildPath $relDecoded)

    $destDir = Split-Path -Parent $destPath
    New-DirIfMissing -path $destDir

        if (-not (Test-Path -LiteralPath $srcPath)) {
            Write-Host "Source not found: $srcPath"
        } else {
            if ($WhatIf) {
                Write-Host ("[WHATIF] Would copy: {0} -> {1}" -f $srcPath, $destPath)
            } else {
                Copy-Item -LiteralPath $srcPath -Destination $destPath -Force
            }
        }
    }

    # Rewrite HTML src paths to ../images/canvas/<rel>
    $newHtml = [System.Text.RegularExpressions.Regex]::Replace(
        $html,
        $pattern,
        { param($m) 'src="../images/canvas/{0}"' -f $m.Groups[1].Value }
    )

    if ($newHtml -ne $html) {
        if ($WhatIf) {
            # Count replacements by diff length heuristic — or re-run regex count
            $count = $imgMatches.Count
            Write-Host ("[WHATIF] Would update: {0} ({1} replacements)" -f $file, $count)
        } else {
            [System.IO.File]::WriteAllText($file, $newHtml)
            Write-Host ("Updated: {0} ({1} replacements)" -f $file, $imgMatches.Count)
        }
    }
}

if ($WhatIf) {
    Write-Host 'Done (preview). Images would be copied to images\canvas and module HTML updated.'
} else {
    Write-Host 'Done. Images copied to images\canvas and module HTML updated.'
}
