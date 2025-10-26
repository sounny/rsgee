# Canvas Content Migration Guide

This guide explains how to use the automated migration scripts to transfer content from your Canvas export to the website structure.

## 📁 Overview

The migration process converts Canvas HTML pages into properly formatted website pages while:
- ✅ Removing UFL video links (ufl.zoom.us)
- ✅ Preserving existing website style and structure
- ✅ Cleaning up Canvas-specific HTML markup
- ✅ Maintaining proper breadcrumb navigation
- ✅ Fixing image paths

## 🛠️ Available Scripts

### 1. PowerShell Script (Windows - Recommended)
**File:** `migrate-content.ps1`

Best for Windows users, provides colored output and detailed progress.

#### Usage:
```powershell
# Dry run - see what will happen without making changes
.\migrate-content.ps1 -DryRun

# Verbose mode - see content previews
.\migrate-content.ps1 -DryRun -Verbose

# Actually run the migration
.\migrate-content.ps1

# Custom paths
.\migrate-content.ps1 -CanvasFolder "path\to\canvas" -OutputFolder "modules"
```

#### Features:
- Color-coded output (success/warning/error)
- Automatic directory creation
- Content preview in verbose mode
- Detailed summary report

### 2. Python Script (Cross-platform)
**File:** `migrate-content.py`

Works on Windows, Mac, and Linux. Requires Python 3.6+.

#### Usage:
```bash
# Dry run
python migrate-content.py --dry-run

# Verbose mode
python migrate-content.py --verbose

# Actually run the migration
python migrate-content.py

# Custom paths
python migrate-content.py --canvas-dir "tobeworkedon/wiki_content" --output-dir "modules"
```

#### Features:
- HTML parsing with cleanup
- Automatic section wrapping
- Cross-platform compatibility
- Clean error handling

## 📋 Content Mapping

The scripts currently map these Canvas pages:

### Week 0 - Welcome (3 pages)
- `welcome-to-remote-sensing.html` → `week-00-welcome/welcome-to-remote-sensing.html`
- `the-earth-engine-api.html` → `week-00-welcome/earth-engine-api.html`
- `why-javascript.html` → `week-00-welcome/why-javascript.html`

### Week 1 - JavaScript Basics (6 pages)
- `introduction-to-javascript.html` → `week-01-javascript/introduction-to-javascript.html`
- `variables.html` → `week-01-javascript/variables.html`
- `lists.html` → `week-01-javascript/lists.html`
- `objects.html` → `week-01-javascript/objects.html`
- `functions.html` → `week-01-javascript/functions.html`
- `comments.html` → `week-01-javascript/comments.html`

### Week 2 - Images and Visualization (5 pages)
- `image-collections.html` → `week-02-images/image-collections.html`
- `google-earth-engine-data-catalogs.html` → `week-02-images/gee-data-catalogs.html`
- `image-manipulation-band-arithmetic-and-thresholds.html` → `week-02-images/band-arithmetic.html`
- `spectral-indices.html` → `week-02-images/spectral-indices.html`
- `ndvi.html` → `week-02-images/ndvi.html`

### Week 3 - Classification (5 pages)
- `introduction-to-image-classification.html` → `week-03-classification/introduction-to-image-classification.html`
- `unsupervised-vs-supervised-vs-object-based.html` → `week-03-classification/unsupervised-vs-supervised.html`
- `land-use-versus-land-cover.html` → `week-03-classification/land-use-vs-land-cover.html`
- `history-of-image-classification.html` → `week-03-classification/history-of-classification.html`
- `unsupervised-classification.html` → `week-03-classification/unsupervised-classification.html`

### Additional Modules
- Week 5: Applications case studies
- Week 6: Public engagement
- Week 7: River morphology theory
- Week 11: Future directions bibliography

## 🔧 Adding More Mappings

To add more pages to the migration, edit the `$contentMap` in PowerShell or `load_content_mapping()` in Python:

### PowerShell:
```powershell
"source-filename.html" = @{
    output = "target-folder\target-filename.html"
    week = "Week X"
    title = "Page Title"
}
```

### Python:
```python
"source-filename.html": {
    "output": "target-folder/target-filename.html",
    "week": "Week X",
    "title": "Page Title"
}
```

## 📝 What the Scripts Do

### Content Processing:
1. **Read Canvas HTML** - Load source file from `tobeworkedon/wiki_content/`
2. **Extract Body Content** - Pull content from `<body>` tags
3. **Remove UFL Videos** - Strip out all `ufl.zoom.us` links and lecture timestamps
4. **Fix Image Paths** - Update Canvas image references to point to `web_resources/`
5. **Clean HTML** - Remove excessive whitespace and empty tags
6. **Apply Template** - Wrap content in website template with proper navigation
7. **Write Output** - Save to `modules/` with correct structure

### Template Structure:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Page Title | Remote Sensing Course</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            [Breadcrumb navigation]
        </nav>
        <header class="lab-header">
            <h1>Page Title</h1>
        </header>
        <main class="lab-content">
            [Canvas content goes here]
        </main>
        <footer>
            [Footer with back link]
        </footer>
    </div>
</body>
</html>
```

## 🎨 Style Preservation

The scripts preserve your existing site style by:
- Using the same CSS: `href="../../css/style.css"`
- Maintaining HTML structure: `container > breadcrumb > header > main > footer`
- Keeping CSS classes: `lab-content`, `lab-header`, etc.
- Not modifying any existing styling

## 📸 Image Handling

Canvas images are referenced as:
```html
<img src="$IMS-CC-FILEBASE$/Uploaded Media/image.png">
```

The scripts convert this to:
```html
<img src="../../tobeworkedon/web_resources/Uploaded Media/image.png">
```

**Manual step needed:** You may want to copy images from `tobeworkedon/web_resources/` to `images/` and update paths.

## ✅ Post-Migration Checklist

After running the migration:

1. **Review Generated Pages**
   - Check for formatting issues
   - Verify code blocks render correctly
   - Ensure images display properly

2. **Test Navigation**
   - Click breadcrumb links
   - Verify all internal links work
   - Check back to home links

3. **Enhance Content** (Optional)
   - Add section headings where helpful
   - Include code examples in proper `<pre>` tags
   - Add figures/diagrams
   - Create info boxes for important notes

4. **Image Migration**
   - Identify which images are used
   - Copy to `images/` folder
   - Update image paths in pages
   - Ensure alt text is descriptive

5. **Update AGENT_MEMORY.md**
   - Mark pages as completed
   - Note any issues encountered
   - Update priority list

## 🚀 Workflow Recommendation

### Phase 1: Foundation (Do First)
```powershell
# Run migration for Week 0-1
.\migrate-content.ps1

# Review generated pages
# Weeks 0 and 1 are most critical for students
```

### Phase 2: Batch Migration
```powershell
# After confirming Phase 1 looks good, add more mappings
# Run for Week 2-3
.\migrate-content.ps1
```

### Phase 3: Advanced Topics
```powershell
# Add remaining pages to mapping
# Run final migration
.\migrate-content.ps1
```

### Phase 4: Manual Enhancements
- Add images
- Enhance formatting
- Add cross-references
- Create navigation between related pages

## 🐛 Troubleshooting

### "Source file not found"
- Check Canvas export is in `tobeworkedon/wiki_content/`
- Verify filename matches exactly (case-sensitive)

### "No content extracted"
- Canvas page might be empty
- Check source HTML manually
- May need special handling for that page

### Images not showing
- Verify path: `../../tobeworkedon/web_resources/...`
- Check if image exists in web_resources
- Consider copying images to main `images/` folder

### Formatting looks wrong
- CSS might not be loading - check path
- Content might need manual section tags
- Code blocks might need `<pre>` wrapping

## 📊 Migration Status

Current status can be tracked in `AGENT_MEMORY.md`:

- ✅ Week 0: Ready to migrate (3 pages)
- ✅ Week 1: Ready to migrate (6 pages)  
- ✅ Week 2: Ready to migrate (5 pages)
- ✅ Week 3: Ready to migrate (5 pages)
- ⏳ Week 5-11: Mappings ready, pending execution

## 🆘 Need Help?

If you encounter issues:

1. Run with `-DryRun` to see what would happen
2. Check `AGENT_MEMORY.md` for known issues
3. Review a generated page to understand the output format
4. Start with a single page before batch processing

## 📝 Notes

- Scripts are idempotent - safe to run multiple times
- Existing files will be overwritten
- Always use `-DryRun` first to preview
- Keep Canvas export as backup reference
- Consider version control (git) before running

---

**Ready to migrate?** Start with a dry run:
```powershell
.\migrate-content.ps1 -DryRun -Verbose
```
