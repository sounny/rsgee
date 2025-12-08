# Teaching Enhancement Guide for RSGEE Course

This guide documents the pedagogical improvements made to the Remote Sensing with Google Earth Engine course materials and provides templates for enhancing additional labs and modules.

## Summary of Changes

### 1. CSS Enhancements (`css/style.css`)
Added 15+ new CSS component classes for consistent, visually distinct teaching elements:

| Class | Purpose | Use Case |
|-------|---------|----------|
| `.learning-objectives` | Green box with checkmarks | Start of every lab/module |
| `.why-it-matters` | Blue "real world" box | Connect concepts to applications |
| `.vocabulary` | Yellow dashed box | Define key terms |
| `.self-check` | Pink box with questions | Pre-submission knowledge check |
| `.troubleshooting` | Red box with issues | Common problems and solutions |
| `.key-concepts` | Green summary box | End-of-section takeaways |
| `.common-mistakes` | Yellow warning box | Errors to avoid |
| `.pro-tips` | Blue tips box | Advanced hints |
| `.builds-on` | Purple link box | Connect to previous learning |
| `.challenge` | Orange challenge box | Stretch activities |
| `.try-it` | Cyan interactive box | Hands-on practice prompts |
| `.expected-output` | Gray output preview | Show what students should see |

### 2. Enhanced Labs (Completed - ALL 25 labs)

**Main Sequence (Labs 1-20):**
- **Lab 1**: Added learning objectives, "why it matters" context, vocabulary, interface walkthrough, self-check questions, troubleshooting guide
- **Lab 2**: Added building on previous learning, complete vocabulary for bands/composites, step-by-step code explanations, try-it prompts
- **Lab 3**: Added learning objectives, vocabulary for JavaScript fundamentals (objects, properties, arrays, functions), code examples, self-check questions, troubleshooting guide, common mistakes
- **Lab 4**: Added learning objectives, vocabulary for nighttime lights, RGB color interpretation table, temporal composite explanations, self-check questions
- **Lab 5**: Added learning objectives, vocabulary (natural/false color composites, scale factors), band reference tables, composite quick reference, self-check questions, troubleshooting guide
- **Lab 6**: Added learning objectives, vocabulary for filtering, step-by-step pipeline visualization, troubleshooting guide, self-check questions
- **Lab 7**: Added learning objectives, vocabulary for dataset characteristics (resolutions), dataset comparison table, categorized dataset cards, pro tips for selection, troubleshooting
- **Lab 8**: Added scientific background for NDVI, NDVI interpretation table, NDWI comparison, calculation-based self-check questions, challenge activity
- **Lab 9**: Added learning objectives, Boolean operator reference table, expected outputs, troubleshooting for thresholds, self-check questions
- **Lab 10**: Added learning objectives, vocabulary for urban mapping (NDBI, SWIR, impervious surface), NDBI interpretation table, comparison to NDVI, self-check questions, troubleshooting, pro tips
- **Lab 11**: Comprehensive enhancement with learning objectives, vocabulary, step-by-step training data collection, CART vs Random Forest comparison, troubleshooting guide
- **Lab 12**: Added learning objectives, vocabulary (k-means, centroid, cluster), supervised vs unsupervised comparison table, workflow explanation, algorithm description, self-check questions, troubleshooting
- **Lab 13**: Added learning objectives, vocabulary (predictor bands, feature space, hyperparameters), improvement strategies table, code examples, self-check questions, troubleshooting guide
- **Lab 14 (Export)**: Added learning objectives, vocabulary (GeoTIFF, export task, AOI), step-by-step export instructions, self-check questions, troubleshooting guide, pro tips for efficient exports
- **Lab 15 (SRTM)**: Added learning objectives, vocabulary (SRTM, DEM, hillshade), step-by-step visualization instructions, parameter tables, self-check questions, troubleshooting guide
- **Lab 16 (Zonal)**: Added learning objectives, vocabulary (zonal statistics, reducer, reduceRegion), parameter tables, common reducers reference, self-check questions, troubleshooting guide, pro tips
- **Lab 17 (Health 1)**: Added learning objectives, vocabulary (vector-borne disease, EPIDEMIA, woreda, NDWI, LST), data product tables, streamlined code, self-check questions, troubleshooting guide, pro tips, references
- **Lab 18 (Health 2)**: Added learning objectives, vocabulary (choropleth, incidence rate, forecast validation), incidence category table, self-check questions, troubleshooting guide, pro tips
- **Lab 19**: Added learning objectives, vocabulary (animation, filmstrip, temporal composite, FPS), workflow table, challenge section, self-check questions, troubleshooting guide, pro tips
- **Lab 20**: Added learning objectives, vocabulary (UI API, widget, split panel, NLCD), UI components table, streamlined code, self-check questions, troubleshooting guide, pro tips, challenge section

**Alternate/Additional Labs (5 files):**
- **Lab 14 (Health)**: Added learning objectives, vocabulary (LST, population-weighted exposure, green space access, heat island), dataset table, self-check questions, troubleshooting, pro tips
- **Lab 15 (UHI)**: Added learning objectives, vocabulary (SUHI, urban/rural mask, GHSL), step-by-step code, self-check questions, troubleshooting guide, pro tips
- **Lab 16 (Wildfire)**: Added learning objectives, vocabulary (NBR, dNBR, burn severity, MTBS), severity classification table, self-check questions, troubleshooting guide, pro tips
- **Lab 17 (River)**: Added learning objectives, vocabulary (MNDWI, centerline, transect, river width), approach overview, self-check questions, troubleshooting guide, pro tips
- **Lab 18 (Final Project)**: Added learning objectives, requirements table, project ideas, detailed rubric table, timeline, self-check questions, common mistakes to avoid

### 3. Enhanced Modules (in progress)
- Week 00–01: Added objectives, why-it-matters, quick wins, try-it prompts, common mistakes, self-checks, expected-output blurbs, and local screenshots for `earth-engine-api.html`, `why-javascript.html`, and Week 01 JavaScript fundamentals.
- Week 02: Applied the same pattern with runnable snippets to `image-collections.html`, `band-arithmetic.html`, `spectral-indices.html`, `ndvi.html`, `understanding-scale.html`, and `gee-data-catalogs.html`.
- Future Directions: Added objectives, trends, next-step planning, and curated bibliography categories with contribution guidance.

### 4. Encoding Fixes Applied
Fixed corrupted characters (replacement character U+FFFD) across multiple files:

**Labs Fixed:**
- Labs 3, 5, 10, 12, 13, 14: Fixed en-dashes in lab ranges (e.g., "Labs 1-4")
- Labs 11, 12: Fixed apostrophes and quotation marks
- Lab 14: Fixed apostrophes in contractions
- Footer navigation: Standardized arrow characters (← →) across all fixed labs

**Modules Fixed (20+ files):**
- `week-00-welcome/why-javascript.html`: Fixed em-dashes and footer arrow
- `week-01-javascript/additive-color-system.html`: Fixed footer arrow
- `week-02-images/band-arithmetic.html`: Fixed footer arrow
- `week-02-images/ndvi.html`: Fixed apostrophes, quotation marks, and wavelength ranges
- `week-03-classification/history-of-classification.html`: Fixed footer arrow
- `week-03-classification/introduction-to-image-classification.html`: Fixed footer arrow
- `week-03-classification/land-use-vs-land-cover.html`: Fixed footer arrow
- `week-03-classification/unsupervised-classification.html`: Fixed quotation marks for "self-taught" and "unsupervised"
- `week-06-public-engagement/engaging-public.html`: Fixed footer arrow
- `week-07-river-morphology/theory.html`: Fixed em-dashes in planview geometry description
- `week-07-river-morphology/part-1-creating-and-analyzing-a-single-river-mask.html`: Fixed apostrophes (JRC's, pixels')
- `week-08-global-snow-observatory/gso-1-about-modis.html`: Fixed NASA's apostrophe
- `week-09-heat-islands/rs3-0-introduction.html`: Fixed 18 page range en-dashes and apostrophes
- `week-09-heat-islands/rs3-2-deriving-land-surface-temperature-from-landsat.html`: Fixed apostrophe (Let's)
- `week-09-heat-islands/rs3-4-defining-urban-and-rural-references.html`: Fixed buffer range en-dash
- `week-09-heat-islands/rs3-5-calculating-the-surface-urban-heat-island-intensity.html`: Fixed degree symbol in code comments
- `week-10-fire/theory.html`: Fixed 20+ page range en-dashes and apostrophes
- `future-directions/bibliography.html`: Fixed special characters in author names and page ranges

---

## Module Enhancement Playbook (use for any remaining modules)

- Structure every module with: short intro paragraph → `learning-objectives` → `why-it-matters` → quick-win code (10–20 lines) → `expected-output` note → `try-it` tweaks → `common-mistakes` → `self-check` → Next steps/links.
- Keep ASCII-only punctuation (replace curly quotes/em-dashes). Verify image paths are local and valid before committing.
- Code hygiene:
  - Always apply scale/offset for surface reflectance (e.g., Landsat SR `* 0.0000275 + -0.2`) before indices.
  - Use correct band names per sensor (L8: B5/B4; S2: B8/B4; SWIR bands per catalog).
  - Set `scale` in reducers/exports; do not let zoom dictate scale. Avoid `Map.addLayer`/`print` inside mapped server functions.
- Visuals: prefer local assets (examples: `images/screenshots/code-editor-interface.png`, `hello-world-console.png`, `images/diagrams/ndvi-formula.png`, `references/images/image1.png`, `image5.png`, `image9.png`, `images/screenshots/Screenshot 2023-02-10 at 5.27.09 AM.png`). Add concise `figcaption` explaining what to notice.
- Reusable snippet patterns:
  - Quick win: center map, add layer, include one reducer/print; keep runnable without extra assets.
  - Try-it: 2–3 small parameter changes (AOI, date range, threshold, palette) to build intuition.
  - Expected output: one sentence describing map/console result instead of large screenshots.
- QA checklist before shipping: ASCII check; image paths exist; breadcrumbs/footers point to `../../index.html`; snippets run as-is in the Code Editor.

## Templates for Enhancing Labs

### Standard Lab Structure
```html
<main class="lab-content">

    <!-- 1. Learning Objectives (REQUIRED for every lab) -->
    <section class="learning-objectives">
        <h3>What You'll Learn</h3>
        <ul>
            <li>First learning outcome (use action verbs)</li>
            <li>Second learning outcome</li>
            <li>Third learning outcome</li>
        </ul>
    </section>

    <!-- 2. Building on Previous Learning (for sequential labs) -->
    <section class="builds-on">
        <h4>Building On Previous Learning</h4>
        <p>This lab builds on <a href="previous-lab.html">Lab X</a> where you learned 
           [concept]. Now you'll extend that by...</p>
    </section>

    <!-- 3. Why It Matters (connect to real world) -->
    <section class="why-it-matters">
        <h3>Why This Matters</h3>
        <p>Scientists and professionals use this technique to:</p>
        <ul>
            <li>Real-world application 1</li>
            <li>Real-world application 2</li>
        </ul>
    </section>

    <!-- 4. Key Vocabulary (define new terms) -->
    <section class="vocabulary">
        <h3>Key Terms</h3>
        <dl>
            <dt>Term 1</dt>
            <dd>Definition of term 1</dd>
            <dt>Term 2</dt>
            <dd>Definition of term 2</dd>
        </dl>
    </section>

    <!-- 5. Lab Instructions (existing content, enhanced) -->
    <section class="lab-steps">
        <h2>Lab Instructions</h2>
        <ol>
            <li>
                <h3>Step 1 - Clear Title</h3>
                <p>Introduction to the step...</p>
                <pre><code>// Code with comments explaining each line</code></pre>
                <p><strong>Understanding the code:</strong></p>
                <ul>
                    <li><code>function</code> - Explanation</li>
                </ul>
                
                <!-- Add after code blocks -->
                <div class="expected-output">
                    <h4>Expected Output</h4>
                    <pre><code>What students should see</code></pre>
                </div>
                
                <!-- Add interactive prompts -->
                <div class="try-it">
                    <h4>Try It</h4>
                    <p>Modify the code to [specific task]...</p>
                </div>
            </li>
        </ol>
    </section>

    <!-- 6. Self-Check Questions (before submission) -->
    <section class="self-check">
        <h3>Check Your Understanding</h3>
        <ol>
            <li>Question testing conceptual understanding?</li>
            <li>Question testing practical application?</li>
            <li>Question requiring interpretation?</li>
        </ol>
        <p><em>Answers: 1) ..., 2) ..., 3) ...</em></p>
    </section>

    <!-- 7. Troubleshooting (common problems) -->
    <section class="troubleshooting">
        <h3>Troubleshooting</h3>
        <div class="issue">
            <strong>Problem: Description of common error</strong>
            <p><strong>Solution:</strong> How to fix it...</p>
        </div>
    </section>

    <!-- 8. Key Concepts Summary -->
    <section class="key-concepts">
        <h3>Key Takeaways</h3>
        <ul>
            <li>Most important concept from this lab</li>
            <li>Second key concept</li>
        </ul>
    </section>

    <!-- 9. Common Mistakes -->
    <section class="common-mistakes">
        <h3>Common Mistakes to Avoid</h3>
        <ul>
            <li><strong>Mistake description:</strong> Why it's wrong and how to avoid</li>
        </ul>
    </section>

    <!-- 10. Pro Tips -->
    <section class="pro-tips">
        <h3>Pro Tips</h3>
        <ul>
            <li>Advanced technique or shortcut</li>
        </ul>
    </section>

    <!-- 11. Submission Box (existing, enhanced with emoji) -->
    <section id="submission">
        <div class="submission-box">
            <h3>📋 Lab Submission</h3>
            <!-- submission details -->
        </div>
    </section>

</main>
```

---

## Templates for Enhancing Modules

### Standard Module Structure
```html
<main class="lab-content">

    <!-- 1. Learning Objectives -->
    <section class="learning-objectives">
        <h3>What You'll Learn</h3>
        <ul>
            <li>Conceptual understanding goal</li>
            <li>Practical skill goal</li>
        </ul>
    </section>

    <!-- 2. Why It Matters -->
    <section class="why-it-matters">
        <h3>Why This Matters</h3>
        <p>Connect concept to real-world applications...</p>
    </section>

    <!-- 3. Vocabulary -->
    <section class="vocabulary">
        <h3>Key Terms</h3>
        <dl>
            <dt>Term</dt>
            <dd>Definition</dd>
        </dl>
    </section>

    <!-- 4. Main Content (with enhanced explanations) -->
    <section>
        <h2>Section Title</h2>
        <p>Clear explanation with progressive complexity...</p>
        
        <!-- Use cards for organizing related concepts -->
        <div class="card">
            <h3>Sub-concept</h3>
            <p>Focused explanation...</p>
        </div>
    </section>

    <!-- 5. Comparison Tables (when comparing approaches) -->
    <table class="schedule-table">
        <thead>
            <tr><th>Factor</th><th>Option A</th><th>Option B</th></tr>
        </thead>
        <tbody>
            <tr><td>Criterion</td><td>Value</td><td>Value</td></tr>
        </tbody>
    </table>

    <!-- 6. Self-Check -->
    <section class="self-check">
        <h3>Check Your Understanding</h3>
        <ol>
            <li>Comprehension question</li>
            <li>Application question</li>
        </ol>
    </section>

    <!-- 7. Try It (hands-on practice) -->
    <section class="try-it">
        <h4>Try It Yourself</h4>
        <p>Practice activity with clear steps...</p>
    </section>

    <!-- 8. Key Takeaways -->
    <section class="key-concepts">
        <h3>Key Takeaways</h3>
        <ul>
            <li>Summary point 1</li>
            <li>Summary point 2</li>
        </ul>
    </section>

</main>
```

---

## Writing Guidelines for Better Teaching

### 1. Use Active Voice and Clear Language
- ❌ "The image is loaded by the function"
- ✅ "The function loads the image"

### 2. Explain the "Why" Before the "How"
- Start with context: "We need to filter images because the collection contains thousands..."
- Then show the technique: "Use `.filterDate()` to select a date range"

### 3. Break Down Code Explanations
```html
<pre><code>var ndvi = image.normalizedDifference(['B5', 'B4']);</code></pre>
<p><strong>Understanding the code:</strong></p>
<ul>
    <li><code>var ndvi</code> - Creates a variable to store the result</li>
    <li><code>.normalizedDifference()</code> - Built-in function that computes (A-B)/(A+B)</li>
    <li><code>['B5', 'B4']</code> - NIR and Red bands (in that order!)</li>
</ul>
```

### 4. Connect to Prior Knowledge
```html
<section class="builds-on">
    <h4>Building On Previous Learning</h4>
    <p>In Lab 2, you used <code>Map.addLayer()</code> to display images. 
       Now we'll learn additional parameters to control the visualization.</p>
</section>
```

### 5. Provide Expected Outputs
Help students verify they're on track by showing what they should see.

### 6. Anticipate Confusion
Use troubleshooting sections to address common stumbling blocks proactively.

### 7. Use Analogies for Abstract Concepts
- Variables → "labeled boxes"
- Bands → "layers in a cake"
- Reducers → "summarizing a book into a sentence"

---

## Priority Labs to Enhance Next

Based on complexity and student difficulty, these labs would benefit most from enhancement:

1. **Lab 11 - Supervised Classification** (already has some elements)
2. **Lab 8 - Band Arithmetic NDVI** (already has some elements)
3. **Lab 6 - Image Collections** (complex filtering concepts)
4. **Lab 4 - Night Time Lights** (first real analysis)
5. **Lab 9 - Thresholds** (decision-making concepts)

---

## Quick Checklist for Any Page

Before considering a page complete, verify it has:

- [ ] Learning objectives at the top
- [ ] "Why it matters" context
- [ ] Key vocabulary defined
- [ ] Code explanations (not just code blocks)
- [ ] At least one "try it" interactive prompt
- [ ] Self-check questions
- [ ] Troubleshooting section
- [ ] Key takeaways summary
- [ ] Proper navigation links in footer

---

*This guide was created to document teaching enhancement patterns. Update as you refine the course materials.*
