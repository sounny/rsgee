# Canvas to Website Migration Script
# This script migrates content from Canvas HTML export to the website structure

param(
    # Root of the Canvas export; wiki pages are under wiki_content, labs under hashed folders
    [string]$CanvasFolder = "tobeworkedon",
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
    "wiki_content\welcome-to-remote-sensing.html" = @{
        output = "modules\week-00-welcome\welcome-to-remote-sensing.html"
        week = "Week 0"
        title = "Welcome to Remote Sensing"
    }
    "wiki_content\the-earth-engine-api.html" = @{
        output = "modules\week-00-welcome\earth-engine-api.html"
        week = "Week 0"
        title = "The Earth Engine API"
    }
    "wiki_content\why-javascript.html" = @{
        output = "modules\week-00-welcome\why-javascript.html"
        week = "Week 0"
        title = "Why JavaScript"
    }
    
    # Week 1 - JavaScript Basics
    "wiki_content\introduction-to-javascript.html" = @{
        output = "modules\week-01-javascript\introduction-to-javascript.html"
        week = "Week 1"
        title = "Introduction to JavaScript"
    }
    "wiki_content\variables.html" = @{
        output = "modules\week-01-javascript\variables.html"
        week = "Week 1"
        title = "Variables"
    }
    "wiki_content\lists.html" = @{
        output = "week-01-javascript\lists.html"
        week = "Week 1"
        title = "Lists"
    }
    "wiki_content\objects.html" = @{
        output = "week-01-javascript\objects.html"
        week = "Week 1"
        title = "Objects"
    }
    "wiki_content\functions.html" = @{
        output = "week-01-javascript\functions.html"
        week = "Week 1"
        title = "Functions"
    }
    "wiki_content\comments.html" = @{
        output = "week-01-javascript\comments.html"
        week = "Week 1"
        title = "Comments"
    }
    "wiki_content\introduction-to-additive-color-system.html" = @{
        output = "week-01-javascript\additive-color-system.html"
        week = "Week 1"
        title = "Introduction to Additive Color System"
    }
    
    # Week 2 - Images and Visualization
    "wiki_content\image-collections.html" = @{
        output = "week-02-images\image-collections.html"
        week = "Week 2"
        title = "Image Collections"
    }
    "wiki_content\google-earth-engine-data-catalogs.html" = @{
        output = "week-02-images\gee-data-catalogs.html"
        week = "Week 2"
        title = "Google Earth Engine Data Catalogs"
    }
    "wiki_content\image-manipulation-band-arithmetic-and-thresholds.html" = @{
        output = "week-02-images\band-arithmetic.html"
        week = "Week 2"
        title = "Image Manipulation: Band Arithmetic and Thresholds"
    }
    "wiki_content\spectral-indices.html" = @{
        output = "week-02-images\spectral-indices.html"
        week = "Week 2"
        title = "Spectral Indices"
    }
    "wiki_content\ndvi.html" = @{
        output = "week-02-images\ndvi.html"
        week = "Week 2"
        title = "NDVI"
    }
    
    # Week 3 - Classification
    "wiki_content\introduction-to-image-classification.html" = @{
        output = "week-03-classification\introduction-to-image-classification.html"
        week = "Week 3"
        title = "Introduction to Image Classification"
    }
    "wiki_content\unsupervised-vs-supervised-vs-object-based.html" = @{
        output = "week-03-classification\unsupervised-vs-supervised.html"
        week = "Week 3"
        title = "Unsupervised vs Supervised vs Object Based"
    }
    "wiki_content\land-use-versus-land-cover.html" = @{
        output = "week-03-classification\land-use-vs-land-cover.html"
        week = "Week 3"
        title = "Land Use Versus Land Cover"
    }
    "wiki_content\history-of-image-classification.html" = @{
        output = "week-03-classification\history-of-classification.html"
        week = "Week 3"
        title = "History of Image Classification"
    }
    "wiki_content\unsupervised-classification.html" = @{
        output = "week-03-classification\unsupervised-classification.html"
        week = "Week 3"
        title = "Unsupervised Classification"
    }
    
    # Week 5 - Applications
    "wiki_content\remote-sensing-applications-case-studies.html" = @{
        output = "week-05-applications\case-studies.html"
        week = "Week 5"
        title = "Remote Sensing Applications Case Studies"
    }
    
    # Week 6 - Public Engagement
    "wiki_content\engaging-with-the-public.html" = @{
        output = "week-06-public-engagement\engaging-public.html"
        week = "Week 6"
        title = "Engaging with the Public"
    }
    
    # Week 7 - River Morphology
    "wiki_content\theory.html" = @{
        output = "week-11-river-morphology\theory.html"
        week = "Week 7"
        title = "River Morphology Theory"
    }
    
    # Week 11 - Future Directions
    "wiki_content\bibliography-for-the-future-directions-in-remote-sensing.html" = @{
        output = "future-directions\bibliography.html"
        week = "Week 11"
        title = "Bibliography for Future Directions"
    }
}

function Extract-BodyContent {
    param(
        [string]$htmlContent,
        [string]$imageBaseRelative
    )
    
    # Remove UFL video links
    $htmlContent = $htmlContent -replace '<p>.*?<a href="https://ufl\.zoom\.us/.*?</a>.*?</p>', ''
    $htmlContent = $htmlContent -replace 'Lecture - Fall 202[0-9] -\s*', ''
    $htmlContent = $htmlContent -replace '<hr>', ''
    
    # Extract content between <body> tags
    if ($htmlContent -match '(?s)<body>(.*?)</body>') {
        $bodyContent = $matches[1].Trim()
        
        # Fix image paths - replace Canvas image references
        if ([string]::IsNullOrWhiteSpace($imageBaseRelative)) {
            $imageBaseRelative = '../../tobeworkedon/web_resources'
        }
        $bodyContent = $bodyContent -replace '\$IMS-CC-FILEBASE\$', $imageBaseRelative
        $bodyContent = $bodyContent -replace 'data-api-endpoint="[^"]*"', ''
        $bodyContent = $bodyContent -replace 'data-api-returntype="[^"]*"', ''

        # Remove Canvas-specific internal references
        $bodyContent = $bodyContent -replace '<a[^>]+href="\$CANVAS_OBJECT_REFERENCE\$/[^"]*"[^>]*>(.*?)</a>', '$1'
        $bodyContent = $bodyContent -replace '<a[^>]+href="\$CANVAS_COURSE_REFERENCE\$/[^"]*"[^>]*>(.*?)</a>', '$1'
        # Remove UFL Zoom links anywhere in body
        $bodyContent = $bodyContent -replace '<a[^>]+href="https://ufl\.zoom\.us/[^>]*>.*?</a>', ''
        
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

# Create Lab page template (labs live one level deep; different breadcrumb and CSS path)
function Create-LabPage {
    param(
        [string]$title,
        [int]$labNumber,
        [string]$bodyContent,
        [string]$prevHref,
        [string]$nextHref
    )

    $prevLink = ""
    $nextLink = ""
    if ($prevHref) { $prevLink = "<a href='$prevHref'>&larr; Previous Lab</a>" }
    if ($nextHref) { $nextLink = "<a href='$nextHref'>Next Lab &rarr;</a>" }
    $navJoin = ""
    if ($prevLink -and $nextLink) { $navJoin = " | " }

    $template = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title | Remote Sensing Course</title>
    <link rel="stylesheet" href="../css/style.css">
    <meta name="robots" content="index, follow">
    <meta name="description" content="Google Earth Engine lab ${labNumber}: ${title}">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="../index.html">Home</a> &gt; <a href="../index.html#labs">Labs</a> &gt; Lab $labNumber
        </nav>

        <header class="lab-header">
            <h1>$title</h1>
        </header>

        <main class="lab-content">
$bodyContent
            <section id="submission">
                <div class="submission-box">
                    <h3>Lab Submission</h3>
                    <p>Submit lab via email.</p>
                    <p><strong>Subject:</strong> <code>$title - [Your Name]</code></p>
                </div>
            </section>
        </main>

        <footer>
            <p>$prevLink$navJoin$nextLink</p>
            <p><a href="../index.html">&larr; Back to Course Home</a></p>
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
    
    # Extract body content (modules: 2 levels deep to tobeworkedon)
    $bodyContent = Extract-BodyContent -htmlContent $canvasContent -imageBaseRelative '../../tobeworkedon/web_resources'
    
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

# Process a Lab page mapping
function Process-LabPage {
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

    Write-Info "Processing lab: $($mapping.title)"

    $canvasContent = Get-Content $canvasPath -Raw -Encoding UTF8

    # Extract body content (labs: 1 level deep to tobeworkedon)
    $bodyContent = Extract-BodyContent -htmlContent $canvasContent -imageBaseRelative '../tobeworkedon/web_resources'

    if ([string]::IsNullOrWhiteSpace($bodyContent)) {
        Write-Warning "  No content extracted from $canvasFile"
        return $false
    }

    # Build lab web page
    $webPage = Create-LabPage -title $mapping.title -labNumber $mapping.lab -bodyContent $bodyContent -prevHref $mapping.prev -nextHref $mapping.next

    # Ensure output directory
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

    # Write file
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

# Mapping for Labs 11–20 (Canvas relative path under root export folder)
$labMap = @{
    # Lab 11
    "g47a41cb339f8b59a160477fbb679c215\lab-11-supervised-classification.html" = @{
        output = "labs\lab-11-supervised-classification.html";
        lab = 11;
        title = "Lab 11 - Supervised Classification";
        prev = "lab-10-challenge-mapping-urban.html";
        next = "lab-12-unsupervised-classification.html";
    }
    # Lab 12
    "g83abe5fda48df9ea87a413be856dc7f6\lab-12-unsupervised-classification.html" = @{
        output = "labs\lab-12-unsupervised-classification.html";
        lab = 12;
        title = "Lab 12 - Unsupervised Classification";
        prev = "lab-11-supervised-classification.html";
        next = "lab-13-improving-classifications.html";
    }
    # Lab 13
    "gd9a036d4cbd478902226e0b0487b2d50\lab-13-improving-your-classifications.html" = @{
        output = "labs\lab-13-improving-classifications.html";
        lab = 13;
        title = "Lab 13 - Improving your Classifications";
        prev = "lab-12-unsupervised-classification.html";
        next = "lab-14-exporting-to-arcgis-pro.html";
    }
    # Lab 14
    "g0a9b6e6593a3bd34a339b34b7328a8e2\lab-14-interoperability-with-gee-exporting-to-arcgis-pro.html" = @{
        output = "labs\lab-14-exporting-to-arcgis-pro.html";
        lab = 14;
        title = "Lab 14 - Interoperability with GEE - Exporting to ArcGIS Pro";
        prev = "lab-13-improving-classifications.html";
        next = "lab-15-visualizing-srtm-data.html";
    }
    # Lab 15
    "g33105de7dace79d610798ae5f8e24afa\lab-15-visualizing-srtm-data.html" = @{
        output = "labs\lab-15-visualizing-srtm-data.html";
        lab = 15;
        title = "Lab 15 - Visualizing SRTM Data";
        prev = "lab-14-exporting-to-arcgis-pro.html";
        next = "lab-16-zonal-statistics.html";
    }
    # Lab 16
    "g3caf98f66d8f06f0d2a58ee130a9b65d\lab-16-zonal-stats.html" = @{
        output = "labs\lab-16-zonal-statistics.html";
        lab = 16;
        title = "Lab 16 - Zonal Statistics";
        prev = "lab-15-visualizing-srtm-data.html";
        next = "lab-17-health-applications-part1.html";
    }
    # Lab 17
    "g8b69574c3631ed2978f1e66c185820ee\lab-17-health-applications-part-1-preparing-data-for-analysis.html" = @{
        output = "labs\lab-17-health-applications-part1.html";
        lab = 17;
        title = "Lab 17 - Health Applications Part 1";
        prev = "lab-16-zonal-statistics.html";
        next = "lab-18-health-applications-part2.html";
    }
    # Lab 18
    "g51c9a193ca3bbb21598af5e9c7f3153e\lab-18-health-applications-part-2.html" = @{
        output = "labs\lab-18-health-applications-part2.html";
        lab = 18;
        title = "Lab 18 - Health Applications Part 2";
        prev = "lab-17-health-applications-part1.html";
        next = "lab-19-making-gifs-and-videos.html";
    }
    # Lab 19
    "g33a00968ab4466635f79ebf7e711f9a9\lab-19-making-a-gifs-and-videos-of-environmental-change.html" = @{
        output = "labs\lab-19-making-gifs-and-videos.html";
        lab = 19;
        title = "Lab 19 - Making GIFs and Videos of Environmental Change";
        prev = "lab-18-health-applications-part2.html";
        next = "lab-20-deploying-gee-apps.html";
    }
    # Lab 20
    "g6ab6b645e8e2c513896f3ecf1a96c1a9\lab-20-design-ui-slash-ux-and-deploying-google-earth-engine-apps.html" = @{
        output = "labs\lab-20-deploying-gee-apps.html";
        lab = 20;
        title = "Lab 20 - Design UI/UX and Deploying Google Earth Engine Apps";
        prev = "lab-19-making-gifs-and-videos.html";
        next = "";
    }
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

Write-Host "`n-- Migrating Module Pages --" -ForegroundColor Cyan
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

Write-Host "`n-- Migrating Lab Pages (11-20) --" -ForegroundColor Cyan
foreach ($canvasFile in $labMap.Keys) {
    try {
        $result = Process-LabPage -canvasFile $canvasFile -mapping $labMap[$canvasFile]
        if ($result) { $processed++ } else { $skipped++ }
    } catch {
        Write-Error "Error processing lab $canvasFile : $_"
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
Write-Host "5. After verification, remove migrated sources from tobeworkedon/"

if ($DryRun) {
    Write-Host "`nRun without -DryRun flag to actually create files" -ForegroundColor Yellow
}
