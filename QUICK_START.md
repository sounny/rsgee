# 🚀 Quick Start: Content Migration Tools

## What You Got

I've created **automated migration tools** to help you quickly convert your Canvas content into properly formatted website pages!

## 📦 Three Tools Created

### 1. **migrate-content.ps1** (Main Migration Script)
- **What it does:** Automatically converts Canvas HTML pages to website format
- **Key features:**
  - ✅ Removes UFL video links
  - ✅ Preserves your website style
  - ✅ Creates proper page structure
  - ✅ Fixes image paths
  - ✅ Clean, formatted output

### 2. **migrate-content.py** (Alternative Script)
- **What it does:** Same as PowerShell but works on any platform
- **Use if:** You prefer Python or need cross-platform support

### 3. **check-migration-status.ps1** (Status Checker)
- **What it does:** Shows which pages are complete, placeholders, or missing
- **Use to:** Track your progress visually

## 🎯 How to Use (3 Simple Steps)

### Step 1: Check Current Status
```powershell
.\check-migration-status.ps1
```
This shows you what needs to be migrated.

### Step 2: Preview Migration (Safe Test)
```powershell
.\migrate-content.ps1 -DryRun -Verbose
```
This shows what WOULD happen without making any changes.

### Step 3: Run the Migration
```powershell
.\migrate-content.ps1
```
This actually creates the pages!

## 📊 What Gets Migrated

The scripts are pre-configured to migrate **22 pages**:

- ✅ **Week 0** (3 pages): Welcome, Earth Engine API, Why JavaScript
- ✅ **Week 1** (6 pages): JavaScript basics (variables, lists, objects, functions, comments, colors)
- ✅ **Week 2** (5 pages): Images, collections, band arithmetic, indices, NDVI
- ✅ **Week 3** (5 pages): Classification theory and methods
- ✅ **Other** (3 pages): Applications, public engagement, river morphology

## 💡 What the Scripts Do

### Input (Canvas Export):
```html
<html>
<body>
<p>Lecture - Fall 2024 - https://ufl.zoom.us/...</p>
<hr>
<p>JavaScript is a programming language...</p>
</body>
</html>
```

### Output (Your Website):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Introduction to JavaScript | Remote Sensing Course</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">...</nav>
        <header class="lab-header">
            <h1>Introduction to JavaScript</h1>
        </header>
        <main class="lab-content">
            <p>JavaScript is a programming language...</p>
        </main>
        <footer>...</footer>
    </div>
</body>
</html>
```

## ⚙️ Key Features

1. **Automatic Video Removal** - All UFL Zoom links are stripped out
2. **Style Preservation** - Uses your existing CSS and HTML structure
3. **Safe Testing** - DryRun mode lets you preview first
4. **Smart Cleanup** - Removes Canvas markup, fixes formatting
5. **Progress Tracking** - Color-coded output shows what's happening

## 📋 Example Output

When you run the script, you'll see:
```
=== Canvas to Website Migration ===
Source: tobeworkedon\wiki_content
Target: modules

Processing: introduction-to-javascript.html
  Created directory: modules\week-01-javascript
  Created: modules\week-01-javascript\introduction-to-javascript.html

Processing: variables.html
  Created: modules\week-01-javascript\variables.html

...

=== Summary ===
✓ Processed: 22 pages
⚠ Skipped: 0 pages
✗ Errors: 0 pages
```

## 🎨 Style Consistency

The scripts maintain your site's look:
- Same CSS file reference
- Same HTML structure
- Same navigation breadcrumbs
- Same footer format

**No visual changes to your design!**

## 📁 File Organization

### Before:
```
tobeworkedon/
  wiki_content/
    introduction-to-javascript.html
    variables.html
    ...
```

### After:
```
modules/
  week-01-javascript/
    introduction-to-javascript.html  ← Formatted for website
    variables.html                   ← Formatted for website
    ...
```

## 🔍 Adding More Pages

Want to migrate additional pages? Easy!

Edit `migrate-content.ps1` and add to `$contentMap`:

```powershell
"your-canvas-file.html" = @{
    output = "week-XX-topic\page-name.html"
    week = "Week X"
    title = "Your Page Title"
}
```

Then run the script again!

## ✅ Quality Checks

After migration, the scripts handle:
- ✅ UFL video links removed
- ✅ Lecture timestamps removed  
- ✅ HTML cleaned and formatted
- ✅ Image paths updated
- ✅ Proper indentation
- ✅ Consistent structure

## 🆘 If Something Goes Wrong

1. **Run with DryRun first** - Always safe to test
2. **Check the status script** - See what's already done
3. **Review MIGRATION_GUIDE.md** - Detailed troubleshooting
4. **Files are backed up** - Canvas content still in `tobeworkedon/`

## 📚 Documentation

Full details in:
- **MIGRATION_GUIDE.md** - Complete usage instructions
- **AGENT_MEMORY.md** - Project context and history
- Script comments - Inline documentation

## 🎉 Ready to Go!

You can now migrate **22 pages** with one command:

```powershell
# See what will happen
.\check-migration-status.ps1

# Test the migration
.\migrate-content.ps1 -DryRun

# Do it!
.\migrate-content.ps1
```

---

**Questions?** Check `MIGRATION_GUIDE.md` for detailed instructions and troubleshooting!
