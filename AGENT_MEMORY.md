# Agent Working Memory & Project Log

## 🎯 Project Mission

**Create the most informative and educational online textbook about using Google Earth Engine for Remote Sensing.**

This is a comprehensive educational resource for teaching remote sensing using Google Earth Engine (GEE). The goal is to provide a standalone, accessible, and engaging learning experience that combines:
- Theoretical concepts in remote sensing
- Practical JavaScript programming skills
- Hands-on labs with real-world applications
- Visual learning through examples and case studies
- Progressive learning from basics to advanced topics

## 📚 Project Overview

**Project Name:** Remote Sensing with Google Earth Engine  
**Target Audience:** College Students 
**Format:** Self-contained HTML website (no LMS required)  
**Primary Technology:** Google Earth Engine JavaScript API  
**Repository:** rsgee (owner: sounny)

## 🗂️ Site Structure

```
rsgee/
├── index.html                 # Main course homepage with schedule
├── css/
│   └── style.css             # Styling for all pages
├── images/
│   ├── animations/           # Animated educational content
│   ├── diagrams/             # Explanatory diagrams
│   └── screenshots/          # GEE interface screenshots
├── js/                       # JavaScript utilities (if needed)
├── labs/                     # 20 hands-on laboratory exercises
│   ├── lab-01-getting-started-with-gee.html
│   ├── lab-02-hello-landsat.html
│   ├── lab-03-js-basics.html
│   ├── lab-04-night-time-lights.html
│   ├── lab-05-challenge-refreshers.html
│   ├── lab-06-image-collections.html
│   ├── lab-07-challenge-finding-dataset.html
│   ├── lab-08-band-arithmetic-ndvi.html
│   ├── lab-09-thresholds.html
│   ├── lab-10-challenge-mapping-urban.html
│   ├── lab-11-supervised-classification.html
│   ├── lab-12-unsupervised-classification.html
│   ├── lab-13-improving-classifications.html
│   ├── lab-14-exporting-to-arcgis-pro.html
│   ├── lab-15-visualizing-srtm-data.html
│   ├── lab-16-zonal-statistics.html (actual filename)
│   ├── lab-16-zonal-stats.html (placeholder created)
│   ├── lab-17-health-applications-part1.html (actual filename)
│   ├── lab-17-health-applications-part-1.html (placeholder created)
│   ├── lab-18-health-applications-part2.html (actual filename)
│   ├── lab-18-health-applications-part-2.html (placeholder created)
│   ├── lab-19-making-gifs-and-videos.html
│   └── lab-20-deploying-gee-apps.html
└── modules/                  # Weekly module content
    ├── week00-welcome.html
    ├── week01-javascript-basics.html
    ├── week02-images-and-visualization.html
    ├── week03-classification.html
    ├── week04-supervised-classification.html
    ├── week05-unsupervised-classification.html
    ├── week06-public-engagement.html
    ├── week07-applications-case-studies.html
    ├── week08-elevation-and-zonal-statistics.html
    ├── week09-research-projects.html
    ├── week10-12-advanced-applications.html
    ├── week13-14-future-directions.html
    └── [subdirectories with detailed content pages]
```

## 📋 Course Structure (Revised Schedule)

### Current Week Organization:
- **Week 0:** Welcome to Remote Sensing
- **Week 1:** JavaScript Basics & Additive Color System
- **Week 2:** Image Collections & Band Arithmetic
- **Week 3:** Land Cover Classes & Classification
- **Week 4:** Interoperability, Elevation, Visualizations
- **Week 5:** Remote Sensing Applications Case Studies
- **Week 6:** Engaging with the Public
- **Week 7:** RS Application 1 - River Morphology
- **Week 8:** RS Application 2 - Global Snow Observatory
- **Week 9:** RS Application 3 - Heat Islands
- **Week 10:** RS Application 4 - Fire
- **Week 11:** Future Directions in Remote Sensing

**Note:** Removed weeks: Term Project, Mid-Semester Review, Spring Break, No Class, Final Project Presentations

## 📁 Source Content Location

**Canvas Export Location:** `tobeworkedon/`
- **Main content:** `tobeworkedon/wiki_content/` (67 HTML pages)
- **Resources:** `tobeworkedon/web_resources/` (images, PDFs, presentations)
- **Manifest:** `tobeworkedon/imsmanifest.xml` (course structure)

### Canvas Content Inventory:
The original Canvas site contains comprehensive content that needs to be migrated:
- Welcome/Introduction pages
- JavaScript tutorial pages (variables, lists, objects, functions, comments)
- Remote sensing theory pages (image classification, land cover, spectral indices)
- Advanced applications (Global Snow Observatory, Heat Islands, Fire, River Morphology)
- Lab instructions and assignments

## ✅ Completed Work

### 2024-10-24: Initial Structure Setup
1. ✅ Removed "Class" column with dates from schedule table
2. ✅ Removed unnecessary rows (weeks 7, 8, 9, 10, 15 old schedule)
3. ✅ Renumbered remaining weeks sequentially (0-11)
4. ✅ Separated "Future Directions in Remote Sensing" into its own week (Week 11)

### 2024-10-26: Link Verification & Placeholder Creation
1. ✅ Audited all links in index.html (140 links total)
2. ✅ Identified broken links (28 broken module links + 3 lab links + 1 modules/index.html)
3. ✅ Created placeholder "Under Development" pages for all broken links:
   - **Week 0 modules:** 3 pages (welcome-to-remote-sensing, earth-engine-api, why-javascript)
   - **Week 1 modules:** 6 pages (intro to JS, variables, lists, objects, functions, additive color)
   - **Week 2 modules:** 5 pages (image collections, GEE catalogs, band arithmetic, spectral indices, NDVI)
   - **Week 3 modules:** 5 pages (intro to classification, supervised vs unsupervised, land use vs cover, history, unsupervised)
   - **Week 5 modules:** 1 page (case studies)
   - **Week 6 modules:** 1 page (engaging public)
   - **Week 7 modules:** 1 page (river morphology theory)
   - **Week 11 modules:** 1 page (bibliography for future directions)
   - **Lab files:** 3 pages (lab-16-zonal-stats, lab-17-part-1, lab-18-part-2)
   - **Modules index:** 1 page
4. ✅ All placeholder pages feature consistent "Under Development" styling with yellow warning banner
5. ✅ All pages include proper breadcrumb navigation and links back to course home

### 2024-10-26: Automated Migration Tools Created
1. ✅ **Created PowerShell migration script** (`migrate-content.ps1`)
   - Automated Canvas HTML to website conversion
   - Removes UFL video links automatically
   - Color-coded output with progress tracking
   - Dry-run mode for safe testing
   - Maps 22+ pages across Week 0-3
2. ✅ **Created Python migration script** (`migrate-content.py`)
   - Cross-platform alternative (Windows/Mac/Linux)
   - HTML parsing with intelligent cleanup
   - Automatic section wrapping
   - Verbose mode for debugging
3. ✅ **Created migration status checker** (`check-migration-status.ps1`)
   - Visual progress tracking
   - Shows complete/placeholder/missing pages
   - Color-coded status display
   - Percentage completion calculator
4. ✅ **Created comprehensive documentation**:
   - `MIGRATION_GUIDE.md` - Detailed instructions and troubleshooting
   - `QUICK_START.md` - Simple getting started guide
   - Inline script comments for maintainability
5. ✅ **Migrated first page manually** - The Earth Engine API page completed as template example

**Migration tools are READY TO USE!** Run `.\check-migration-status.ps1` to see current status.

## 🚧 Known Issues & Inconsistencies

### File Naming Discrepancies
There are duplicate lab files with different naming conventions:
- `lab-16-zonal-statistics.html` (actual) vs `lab-16-zonal-stats.html` (placeholder)
- `lab-17-health-applications-part1.html` (actual) vs `lab-17-health-applications-part-1.html` (placeholder)
- `lab-18-health-applications-part2.html` (actual) vs `lab-18-health-applications-part-2.html` (placeholder)

**Resolution needed:** Decide on consistent naming and update index.html accordingly, or delete placeholders if actual files have content.

### Module Structure
- Main module files exist at top level: `modules/week0X-topic.html`
- Detailed content pages created in subdirectories: `modules/week-0X-topic/page.html`
- These represent two different content structures that need reconciliation

### Missing Content
All placeholder pages need actual educational content developed.

## 📝 Content Development Priorities

### High Priority (Foundation Topics)
1. **Week 0 - Welcome Pages**
   - Welcome to Remote Sensing: Course introduction, RS fundamentals
   - Earth Engine API: API concepts, JavaScript basics in GEE context
   - Why JavaScript: Rationale for JS, comparison with Python

2. **Week 1 - JavaScript Fundamentals**
   - Introduction to JavaScript: Syntax, data types, operators
   - Variables: Declaration, scope, naming conventions
   - Lists (Arrays): Creating, accessing, methods
   - Objects: Key-value pairs, nested objects
   - Functions: Definition, parameters, return values
   - Additive Color System: RGB, color composites for remote sensing

3. **Week 2 - Image Processing Basics**
   - Image Collections: ee.ImageCollection, filtering, sorting
   - GEE Data Catalogs: Available datasets, metadata
   - Band Arithmetic: Mathematical operations on bands
   - Spectral Indices: Common indices, applications
   - NDVI: Normalized Difference Vegetation Index explained

### Medium Priority (Core Techniques)
4. **Week 3 - Classification Theory**
   - Introduction to Image Classification
   - Unsupervised vs Supervised vs Object-Based
   - Land Use vs Land Cover concepts
   - History of Image Classification
   - Unsupervised Classification methods

5. **Week 5 - Applications**
   - Remote Sensing Applications Case Studies

6. **Week 6 - Communication**
   - Engaging with the Public

### Lower Priority (Advanced Topics)
7. **Week 7 - River Morphology**
   - Theory page content

8. **Week 11 - Future Directions**
   - Bibliography page (comprehensive reading list)

## 🎯 Next Steps & Todo List

### 🚀 IMMEDIATE: Use Migration Tools (NEW!)

**Automated migration scripts are now available!** See `MIGRATION_GUIDE.md` for detailed instructions.

#### Quick Start:
```powershell
# Test first with dry run
.\migrate-content.ps1 -DryRun -Verbose

# Run the migration
.\migrate-content.ps1
```

This will automatically migrate:
- ✅ Week 0 pages (3 pages)
- ✅ Week 1 JavaScript pages (6 pages)
- ✅ Week 2 Image processing pages (5 pages)
- ✅ Week 3 Classification pages (5 pages)
- ✅ Additional module pages (3 pages)

**Total: 22 pages automated!**

### Phase 1: Content Migration from Canvas (PRIORITY)
- [ ] Review and catalog all Canvas wiki_content HTML files
- [ ] Map Canvas content to current website structure
- [ ] Migrate content systematically, maintaining style consistency
- [ ] Extract and organize images from web_resources folder
- [ ] Update links to match new site structure
- [ ] Remove UFL-hosted video links (per user request)

### Content Migration Strategy:
1. **Start with foundation (Week 0-2):** Most critical for student learning
2. **Preserve existing style:** Don't change CSS/layout without confirmation
3. **Maintain structure:** Keep current breadcrumb navigation and page organization
4. **Extract all content:** Code examples, images, explanations from Canvas pages
5. **Update placeholders:** Replace "Under Development" pages with real content

### Immediate Actions
- [ ] Review actual lab files (16, 17, 18) to determine if placeholders should be deleted
- [ ] Standardize file naming conventions across all labs
- [ ] Update all links in index.html to match actual file names
- [ ] Verify existence of all image files referenced in existing content
- [ ] Check if `modules/index.html` should be a real navigation page or can be removed

### Content Development Tasks
- [ ] Develop Week 0 content (3 pages) - Foundation for entire course
- [ ] Develop Week 1 JavaScript content (6 pages) - Critical for student success
- [ ] Develop Week 2 image processing content (5 pages) - Core RS concepts
- [ ] Develop Week 3 classification content (5 pages)
- [ ] Add code examples to all JavaScript tutorials
- [ ] Create diagrams/screenshots for each concept
- [ ] Add interactive elements where appropriate

### Video Content
- [ ] Audit all lab pages for UFL-hosted video links
- [ ] Remove UFL-hosted videos as requested
- [ ] Remove video panels if no videos remain
- [ ] Consider creating new video content or linking to alternative resources

### Quality Assurance
- [ ] Test all internal links
- [ ] Test all external links (GitHub, NASA, etc.)
- [ ] Verify responsive design on mobile devices
- [ ] Check accessibility (alt text, semantic HTML, contrast)
- [ ] Proofread all existing content for typos/errors
- [ ] Ensure consistent terminology across all pages

### Enhancement Ideas
- [ ] Add search functionality
- [ ] Create printable PDF versions of each module
- [ ] Add progress tracking (checkboxes for completed labs)
- [ ] Include downloadable code snippets
- [ ] Add interactive code playgrounds
- [ ] Create glossary of terms
- [ ] Add FAQ section
- [ ] Include student project showcase

## 🧠 Agent Instructions

### When Working on This Project:

1. **Maintain Consistency:**
   - Use the same HTML structure across all pages
   - Keep breadcrumb navigation consistent
   - Ensure CSS classes match existing styles
   - Follow established naming conventions

2. **Educational Focus:**
   - Write clearly for students new to both remote sensing and programming
   - Include practical examples with every concept
   - Build progressively from simple to complex
   - Provide context for why each technique matters

3. **Code Quality:**
   - All GEE JavaScript code should be complete and runnable
   - Include comments explaining each step
   - Use meaningful variable names
   - Follow GEE best practices

4. **Visual Learning:**
   - Include images, diagrams, and screenshots generously
   - Use captions to explain what viewers should observe
   - Consider animated GIFs for dynamic processes
   - Color-code examples for clarity

5. **Before Making Changes:**
   - Read this AGENT_MEMORY.md file
   - Check the current structure in the relevant section
   - Update this file with completed work
   - Note any new issues discovered

6. **After Completing Work:**
   - Update the "Completed Work" section with date and description
   - Move completed items from "Todo List" to "Completed Work"
   - Add any new discoveries to "Known Issues"
   - Update "Next Steps" with new priorities

## 📚 Key Remote Sensing Concepts to Cover

### Fundamental Concepts
- Electromagnetic spectrum
- Spectral signatures
- Spatial, spectral, temporal, radiometric resolution
- Passive vs active sensors
- Atmospheric correction
- Geometric correction

### Image Processing
- Image enhancement (stretching, filtering)
- Band ratios and indices
- Principal Component Analysis
- Image transformations
- Mosaicking and compositing

### Classification & Analysis
- Supervised classification algorithms
- Unsupervised classification (K-means, ISODATA)
- Accuracy assessment (confusion matrix, kappa)
- Change detection techniques
- Time series analysis

### Applications
- Land cover/land use mapping
- Vegetation monitoring (NDVI, EVI)
- Water resources (water detection, quality)
- Urban analysis (growth, heat islands)
- Disaster response (floods, fires)
- Agriculture (crop monitoring, yield prediction)
- Climate change indicators

## 🔗 Important External Resources

- [Google Earth Engine Documentation](https://developers.google.com/earth-engine)
- [GEE Code Editor](https://code.earthengine.google.com/)
- [Earth Engine Data Catalog](https://developers.google.com/earth-engine/datasets)
- [GEE Community Tutorials](https://developers.google.com/earth-engine/tutorials/community/explore)

## 💡 Design Philosophy

1. **Accessibility First:** No paywalls, no LMS required, works on any device
2. **Hands-On Learning:** Every concept paired with practical exercise
3. **Real-World Relevance:** Applications addressing actual environmental challenges
4. **Progressive Complexity:** Build confidence before increasing difficulty
5. **Open Educational Resource:** Free, shareable, modifiable for other educators

---

**Last Updated:** 2024-10-26  
**Project Status:** Active Development - Foundation Complete, Content Development Phase  
**Current Focus:** Creating educational content for placeholder pages, starting with foundational weeks
