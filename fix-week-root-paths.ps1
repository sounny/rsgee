# Fix CSS and home links in top-level week-* pages (not under modules/)
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSCommandPath
$weekRoots = Get-ChildItem -LiteralPath $repoRoot -Directory -Filter 'week-*' | Select-Object -ExpandProperty FullName

foreach ($dir in $weekRoots) {
    $htmlFiles = Get-ChildItem -LiteralPath $dir -Filter '*.html' -File -Recurse
    foreach ($f in $htmlFiles) {
        $text = [System.IO.File]::ReadAllText($f.FullName)
        $orig = $text
        $text = $text -replace 'href="\.{2}/\.{2}/css/style\.css"', 'href="../css/style.css"'
        $text = $text -replace 'href="\.{2}/\.{2}/index\.html#schedule"', 'href="../index.html#schedule"'
        $text = $text -replace 'href="\.{2}/\.{2}/index\.html"', 'href="../index.html"'
        # Fix mojibake left arrow
        $text = $text -replace 'â†', '&larr;'
        if ($text -ne $orig) {
            [System.IO.File]::WriteAllText($f.FullName, $text)
            Write-Host ("Updated: {0}" -f $f.FullName)
        }
    }
}

Write-Host 'Done fixing paths in top-level week-* pages.'
