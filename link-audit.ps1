# Site-wide link and asset audit for local files
param(
    [string]$Root = '.',
    [switch]$IncludeExternal # currently not used (no http checks)
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path -LiteralPath $Root | Select-Object -ExpandProperty Path
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$reportDir = Join-Path -Path $repoRoot -ChildPath 'reports'
if (-not (Test-Path -LiteralPath $reportDir)) { New-Item -ItemType Directory -Path $reportDir | Out-Null }
$reportPath = Join-Path -Path $reportDir -ChildPath ("link-audit-{0}.txt" -f $timestamp)

function Write-Report([string]$line) {
    Add-Content -LiteralPath $reportPath -Value $line
}

function Test-ValidPath([string]$p) {
    if (-not $p) { return $false }
    $invalid = [System.IO.Path]::GetInvalidPathChars()
    foreach ($ch in $invalid) {
        if ($p.IndexOf($ch) -ge 0) { return $false }
    }
    return $true
}

# Collect HTML files excluding Canvas export folders (ensure only *.html are returned)
# Use -notlike patterns to avoid any regex edge cases on Windows paths
$htmlFiles = Get-ChildItem -Path $repoRoot -Recurse -Filter *.html -File |
    Where-Object {
        $_.FullName -notlike "*\tobeworkedon\*" -and
        $_.FullName -notlike "*\_archived_labs*" -and
        $_.FullName -notlike "*\node_modules\*" -and
        $_.FullName -notlike "*\dist\*" -and
        $_.FullName -notlike "*\build\*"
    }

Write-Report ("Link Audit Report - {0}" -f (Get-Date))
Write-Report ("Repository root: {0}" -f $repoRoot)
Write-Report ""

$totalLinks = 0
$missingFiles = @()
$missingAnchors = @()

# Regexes
$hrefRx = 'href\s*=\s*"([^"]+)"'
$srcRx  = 'src\s*=\s*"([^"]+)"'

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $links = New-Object System.Collections.Generic.List[string]
    [System.Text.RegularExpressions.Regex]::Matches($content, $hrefRx) | ForEach-Object { $links.Add($_.Groups[1].Value) }
    [System.Text.RegularExpressions.Regex]::Matches($content, $srcRx)  | ForEach-Object { $links.Add($_.Groups[1].Value) }

    $fileDir = Split-Path -Parent $file.FullName

    foreach ($raw in $links) {
        $totalLinks++
        $url = $raw.Trim()
        if ([string]::IsNullOrWhiteSpace($url)) { continue }
        # Skip external and special schemes
        if ($url -match '^(?i)(https?:|mailto:|tel:|data:|javascript:)') { continue }

        $targetPath = $null
        $fragment = $null

        if ($url.StartsWith('#')) {
            # In-page anchor
            $fragment = $url.TrimStart('#')
            $targetPath = $file.FullName
        } else {
            # Remove query and fragment
            $noQuery = $url.Split('?')[0]
            $parts = $noQuery.Split('#',2)
            $rel = $parts[0]
            if ($parts.Count -gt 1) { $fragment = $parts[1] }

            # Normalize relative path
            $decodedRel = [System.Uri]::UnescapeDataString($rel)
            $combined = Join-Path -Path $fileDir -ChildPath $decodedRel
            # Resolve path safely
            try {
                $targetPath = [System.IO.Path]::GetFullPath($combined)
            } catch {
                $targetPath = $combined
            }
        }

        if ($null -ne $targetPath) {
            if (-not (Test-ValidPath $targetPath) -or -not (Test-Path -LiteralPath $targetPath)) {
                # Record missing file; try to suggest Canvas source candidate
                $relToRepo = $targetPath.Replace($repoRoot, '').TrimStart('\\')
                $candidate = $null
                $baseName = $null
                if (Test-ValidPath $targetPath) {
                    $baseName = [System.IO.Path]::GetFileName($targetPath)
                }
                if ($baseName) {
                    $canvasMatches = Get-ChildItem -LiteralPath (Join-Path $repoRoot 'tobeworkedon') -Recurse -File -ErrorAction SilentlyContinue |
                        Where-Object { $_.Name -ieq $baseName }
                    if ($canvasMatches) { $candidate = ($canvasMatches | Select-Object -First 1).FullName }
                }
                $missingFiles += [pscustomobject]@{ File=$file.FullName; Link=$url; Target=$relToRepo; CanvasCandidate=$candidate }
                continue
            }

            if ($fragment) {
                # Validate fragment id/name exists in target file
                try {
                    $targetHtml = [System.IO.File]::ReadAllText($targetPath)
                    $fragRx = ('(?i)(id|name)\s*=\s*"{0}"' -f [System.Text.RegularExpressions.Regex]::Escape($fragment))
                    if (-not [System.Text.RegularExpressions.Regex]::IsMatch($targetHtml, $fragRx)) {
                        $missingAnchors += [pscustomobject]@{ File=$file.FullName; Link=$url; Target=$targetPath; Fragment=$fragment }
                    }
                } catch {}
            }
        }
    }
}

Write-Report ("Scanned HTML files: {0}" -f $htmlFiles.Count)
Write-Report ("Total href/src links scanned: {0}" -f $totalLinks)
Write-Report ""

Write-Report ("Missing files: {0}" -f $missingFiles.Count)
foreach ($m in $missingFiles) {
    Write-Report ("- In: {0}" -f $m.File)
    Write-Report ("  Link: {0}" -f $m.Link)
    Write-Report ("  Target (resolved): {0}" -f $m.Target)
    if ($m.CanvasCandidate) { Write-Report ("  Canvas candidate: {0}" -f $m.CanvasCandidate) }
}

Write-Report ""
Write-Report ("Missing anchors: {0}" -f $missingAnchors.Count)
foreach ($a in $missingAnchors) {
    Write-Report ("- In: {0}" -f $a.File)
    Write-Report ("  Link: {0}" -f $a.Link)
    Write-Report ("  Target file: {0}" -f $a.Target)
    Write-Report ("  Fragment: {0}" -f $a.Fragment)
}

Write-Host ("Audit complete. Report saved to {0}" -f $reportPath)
