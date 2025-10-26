# Canvas to Website Migration Script
# This script migrates content from Canvas HTML export to the website structure

param(
    [string]$CanvasFolder = "tobeworkedon\wiki_content",
    [string]$OutputFolder = ".",
    [switch]$DryRun,
    [switch]$Verbose
)

# Color output functions
function Write-Success { param($msg) Write-Host $msg -ForegroundColor Green }
function Write-Warning { param($msg) Write-Host $msg -ForegroundColor Yellow }
function Write-Info { param($msg) Write-Host $msg -ForegroundColor Cyan }
function Write-Error { param($msg) Write-Host $msg -ForegroundColor Red }

# Mapping of Canvas pages to website structure
$contentMap = @{
    # Week 0 - Welcome
    "welcome-to-remote-sensing.html" = @{
        output = "modules\week-00-welcome\welcome-to-remote-sensing.html"
        week = "Week 0"
        title = "Welcome to Remote Sensing"
    }
    "the-earth-engine-api.html" = @{
        output = "modules\week-00-welcome\earth-engine-api.html"
        week = "Week 0"
        title = "The Earth Engine API"
    }
    "why-javascript.html" = @{
        output = "modules\week-00-welcome\why-javascript.html"
        week = "Week 0"
        title = "Why JavaScript"
    }
    
    # Week 1 - JavaScript Basics
    "introduction-to-javascript.html" = @{
        output = "modules\week-01-javascript\introduction-to-javascript.html"
        week = "Week 1"
        title = "Introduction to JavaScript"
    }
    "variables.html" = @{
        output = "modules\week-01-javascript\variables.html"
        week = "Week 1"
        title = "Variables"
    }
    "lists.html" = @{
        output = "week-01-javascript\lists.html"
        week = "Week 1"
        title = "Lists"
    }
    "objects.html" = @{
        output = "week-01-javascript\objects.html"
        week = "Week 1"
        title = "Objects"
    }
    "functions.html" = @{
        output = "week-01-javascript\functions.html"
        week = "Week 1"
        title = "Functions"
    }
    "comments.html" = @{
        output = "week-01-javascript\comments.html"
        week = "Week 1"
        title = "Comments"
    }
    "introduction-to-additive-color-system.html" = @{
        output = "week-01-javascript\additive-color-system.html"
        week = "Week 1"
        title = "Introduction to Additive Color System"
    }
    
    # Week 2 - Images and Visualization
    "image-collections.html" = @{
        output = "week-02-images\image-collections.html"
        week = "Week 2"
        title = "Image Collections"
    }
    "google-earth-engine-data-catalogs.html" = @{
        output = "week-02-images\gee-data-catalogs.html"
        week = "Week 2"
        title = "Google Earth Engine Data Catalogs"
    }
    "image-manipulation-band-arithmetic-and-thresholds.html" = @{
        output = "week-02-images\band-arithmetic.html"
        week = "Week 2"
        title = "Image Manipulation: Band Arithmetic and Thresholds"
    }
    "spectral-indices.html" = @{
        output = "week-02-images\spectral-indices.html"
        week = "Week 2"
        title = "Spectral Indices"
    }
    "ndvi.html" = @{
        output = "week-02-images\ndvi.html"
        week = "Week 2"
        title = "NDVI"
    }
    
    # Week 3 - Classification
    "introduction-to-image-classification.html" = @{
        output = "week-03-classification\introduction-to-image-classification.html"
        week = "Week 3"
        title = "Introduction to Image Classification"
    }
    "unsupervised-vs-supervised-vs-object-based.html" = @{
        output = "week-03-classification\unsupervised-vs-supervised.html"
        week = "Week 3"
        title = "Unsupervised vs Supervised vs Object Based"
    }
    "land-use-versus-land-cover.html" = @{
        output = "week-03-classification\land-use-vs-land-cover.html"
        week = "Week 3"
        title = "Land Use Versus Land Cover"
    }
    "history-of-image-classification.html" = @{
        output = "week-03-classification\history-of-classification.html"
        week = "Week 3"
        title = "History of Image Classification"
    }
    "unsupervised-classification.html" = @{
        output = "week-03-classification\unsupervised-classification.html"
        week = "Week 3"
        title = "Unsupervised Classification"
    }
    
    # Week 5 - Applications
    "remote-sensing-applications-case-studies.html" = @{
        output = "week-05-applications\case-studies.html"
        week = "Week 5"
        title = "Remote Sensing Applications Case Studies"
    }
    
    # Week 6 - Public Engagement
    "engaging-with-the-public.html" = @{
        output = "week-06-public-engagement\engaging-public.html"
        week = "Week 6"
        title = "Engaging with the Public"
    }
    
    # Week 7 - River Morphology
    "theory.html" = @{
        output = "week-11-river-morphology\theory.html"
        week = "Week 7"
        title = "River Morphology Theory"
    }
    
    # Week 11 - Future Directions
    "bibliography-for-the-future-directions-in-remote-sensing.html" = @{
        output = "future-directions\bibliography.html"
        week = "Week 11"
        title = "Bibliography for Future Directions"
    }
}

function Extract-BodyContent {
    param([string]$htmlContent)
    
    # Remove UFL video links
    $htmlContent = $htmlContent -replace '<p>.*?<a href="https://ufl\.zoom\.us/.*?</a>.*?</p>', ''
    $htmlContent = $htmlContent -replace 'Lecture - Fall 202[0-9] -\s*', ''
    $htmlContent = $htmlContent -replace '<hr>', ''
    
    # Extract content between <body> tags
    if ($htmlContent -match '(?s)<body>(.*?)</body>') {
        $bodyContent = $matches[1].Trim()
        
        # Fix image paths - replace Canvas image references
        $bodyContent = $bodyContent -replace '\$IMS-CC-FILEBASE\$', '../../tobeworkedon/web_resources'
        $bodyContent = $bodyContent -replace 'data-api-endpoint="[^"]*"', ''
        $bodyContent = $bodyContent -replace 'data-api-returntype="[^"]*"', ''
        
        # Clean up excessive whitespace
        $bodyContent = $bodyContent -replace '\n\s*\n\s*\n+', "`n`n"
        
        return $bodyContent
    }
    
    return ""
}

function Create-WebPage {
    param(
        [string]$title,
        [string]$week,
        [string]$bodyContent
    )
    
    $template = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title | Remote Sensing Course</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="../../index.html">Home</a> &gt; <a href="../../index.html#schedule">Schedule</a> &gt; $week
        </nav>

        <header class="lab-header">
            <h1>$title</h1>
        </header>

        <main class="lab-content">
$bodyContent
        </main>

        <footer>
            <p><a href="../../index.html">← Back to Course Home</a></p>
            <p><strong>Remote Sensing with Google Earth Engine</strong></p>
        </footer>
    </div>
</body>
</html>
"@
    
    return $template
}

function Process-CanvasPage {
    param(
        [string]$canvasFile,
        [hashtable]$mapping
    )
    
    $canvasPath = Join-Path $CanvasFolder $canvasFile
    $outputPath = Join-Path $OutputFolder $mapping.output
    
    if (-not (Test-Path $canvasPath)) {
        Write-Warning "Source file not found: $canvasPath"
        return $false
    }
    
    Write-Info "Processing: $canvasFile"
    
    # Read Canvas HTML
    $canvasContent = Get-Content $canvasPath -Raw -Encoding UTF8
    
    # Extract body content
    $bodyContent = Extract-BodyContent $canvasContent
    
    if ([string]::IsNullOrWhiteSpace($bodyContent)) {
        Write-Warning "  No content extracted from $canvasFile"
        return $false
    }
    
    # Create web page
    $webPage = Create-WebPage -title $mapping.title -week $mapping.week -bodyContent $bodyContent
    
    # Create output directory if needed
    $outputDir = Split-Path $outputPath -Parent
    $fullOutputDir = Join-Path $OutputFolder $outputDir
    
    if (-not (Test-Path $fullOutputDir)) {
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $fullOutputDir -Force | Out-Null
            Write-Success "  Created directory: $fullOutputDir"
        } else {
            Write-Info "  [DRY RUN] Would create directory: $fullOutputDir"
        }
    }
    
    # Write output file
    $fullOutputPath = $outputPath
    
    if (-not $DryRun) {
        $webPage | Out-File -FilePath $fullOutputPath -Encoding UTF8
        Write-Success "  Created: $outputPath"
    } else {
        Write-Info "  [DRY RUN] Would create: $outputPath"
    }
    
    if ($Verbose) {
        Write-Host "  Content preview:" -ForegroundColor Gray
        Write-Host "  $($bodyContent.Substring(0, [Math]::Min(200, $bodyContent.Length)))..." -ForegroundColor Gray
    }
    
    return $true
}

# Main execution
Write-Host "`n=== Canvas to Website Migration Script ===" -ForegroundColor Magenta
Write-Host "Source: $CanvasFolder" -ForegroundColor Cyan
Write-Host "Target: $OutputFolder" -ForegroundColor Cyan

if ($DryRun) {
    Write-Warning "`n[DRY RUN MODE - No files will be modified]`n"
}

$processed = 0
$skipped = 0
$errors = 0

foreach ($canvasFile in $contentMap.Keys) {
    try {
        $result = Process-CanvasPage -canvasFile $canvasFile -mapping $contentMap[$canvasFile]
        if ($result) {
            $processed++
        } else {
            $skipped++
        }
    } catch {
        Write-Error "Error processing $canvasFile : $_"
        $errors++
    }
    Write-Host ""
}

# Summary
Write-Host "`n=== Migration Summary ===" -ForegroundColor Magenta
Write-Success "Processed: $processed pages"
if ($skipped -gt 0) { Write-Warning "Skipped: $skipped pages" }
if ($errors -gt 0) { Write-Error "Errors: $errors pages" }

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Review generated pages for formatting issues"
Write-Host "2. Check image references and move images as needed"
Write-Host "3. Add any missing sections or enhancements"
Write-Host "4. Update AGENT_MEMORY.md with completed migrations"

if ($DryRun) {
    Write-Host "`nRun without -DryRun flag to actually create files" -ForegroundColor Yellow
}
