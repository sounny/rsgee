# 📐 Textbook Style Guide

This guide ensures consistency across all modules and labs in the *Remote Sensing with Google Earth Engine* course.

---

## Document Structure

### Required Sections (Every Module)

```html
<section class="learning-objectives">...</section>  <!-- What will students learn -->
<section class="why-it-matters">...</section>       <!-- Real-world relevance -->
<!-- Main content -->
<section class="try-it">...</section>               <!-- Hands-on practice -->
<section class="self-check">...</section>           <!-- Review questions -->
```

### Optional Sections (As Needed)

```html
<section class="vocabulary">...</section>           <!-- New terms -->
<section class="common-mistakes">...</section>      <!-- Error prevention -->
<section class="pro-tips">...</section>             <!-- Advanced insights -->
<section class="builds-on">...</section>            <!-- Prerequisites -->
<section class="troubleshooting">...</section>      <!-- Problem solving -->
```

---

## Headings

| Level | Usage | Case Style | Example |
|-------|-------|------------|---------|
| `<h1>` | Page title only | Title Case | "Introduction to Image Classification" |
| `<h2>` | Major sections | Title Case | "The Classification Workflow" |
| `<h3>` | Subsections, special boxes | Sentence case | "Learning objectives" |
| `<h4>` | Minor headings | Sentence case | "Try it yourself" |

---

## Code Examples

### Comments
- Use sentence case
- Only use periods for multi-sentence comments
- Keep comments concise

```javascript
// Good: Load and filter the collection
// Good: Apply cloud mask. Then calculate NDVI.
// Bad: load and filter the collection.
// Bad: Apply cloud mask
```

### Band Names
Always use the exact band names from the product:

| Product | NIR | Red | SWIR1 | SWIR2 |
|---------|-----|-----|-------|-------|
| Landsat 8/9 SR | SR_B5 | SR_B4 | SR_B6 | SR_B7 |
| Landsat 8/9 TOA | B5 | B4 | B6 | B7 |
| Sentinel-2 | B8 | B4 | B11 | B12 |
| MODIS SR | sur_refl_b02 | sur_refl_b01 | sur_refl_b06 | sur_refl_b07 |

### Scale/Offset
Always apply scale factors for Surface Reflectance:

```javascript
// Landsat Collection 2 SR
.multiply(0.0000275).add(-0.2)

// Sentinel-2 (divide by 10000)
.divide(10000)
```

### Reducers
Always specify `scale` and `maxPixels`:

```javascript
var stats = image.reduceRegion({
  reducer: ee.Reducer.mean(),
  geometry: roi,
  scale: 30,           // REQUIRED
  maxPixels: 1e9       // REQUIRED for large regions
});
```

---

## HTML Structure

### Required Meta Tags

```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="[50-160 character description]">
```

### Container Wrapper
All content should be wrapped:

```html
<div class="container">
  <nav class="breadcrumb">...</nav>
  <header class="lab-header">...</header>
  <main class="lab-content">...</main>
  <footer>...</footer>
</div>
```

### Standard Footer

```html
<footer>
  <p><a href="../../index.html">← Back to Course Home</a></p>
  <p><strong>Remote Sensing with Google Earth Engine</strong></p>
</footer>
```

---

## Images and Figures

### Filenames
- Use kebab-case: `ndvi-florida-2023.png` ✓
- Avoid spaces: `Screenshot 2023-11-16.png` ✗
- Be descriptive: `bob-cat-fire-thermal.png` ✓

### Figure Structure

```html
<figure>
  <img src="../../images/category/filename.png" 
       alt="Descriptive alt text for accessibility"
       loading="lazy">
  <figcaption>Caption explaining what to notice in the image.</figcaption>
</figure>
```

### Alt Text
- Be specific: "NDVI map showing vegetation in green and bare soil in brown"
- Not generic: "map" or "screenshot"

---

## Writing Style

### Voice and Tone
- **Direct**: "Click Run to execute the script" not "One should click Run"
- **Second person**: "You will learn..." not "Students will learn..."
- **Active voice**: "The function calculates NDVI" not "NDVI is calculated by the function"

### Paragraphs
- Keep to 3-4 sentences maximum
- Lead with the main point
- One idea per paragraph

### Technical Terms
- Define on first use
- Use `<code>` for function names, band names, operators
- Use `<strong>` for emphasis

---

## Punctuation

### Quotation Marks
- Code examples: straight quotes `'string'` or `"string"`
- Prose: smart quotes "like this" (optional, straight acceptable)

### Em-Dashes
- Use proper em-dash (—) or double hyphen (--)
- Not single hyphen for parenthetical phrases

### Lists
- Use periods at end of complete sentences
- No periods for fragments or short items
- Maintain consistency within each list

---

## Cross-References

### Builds-On Section

```html
<section class="builds-on">
  <h3>This module builds on</h3>
  <ul>
    <li><a href="../week-01-javascript/functions.html">Functions</a> - mapping over collections</li>
    <li><a href="image-collections.html">Image Collections</a> - filtering and compositing</li>
  </ul>
</section>
```

### Next Steps Section

```html
<section>
  <h2>Next steps</h2>
  <ul>
    <li><a href="next-module.html">Next Module: Topic Name</a></li>
    <li><a href="related-lab.html">Lab X: Hands-on Practice</a></li>
  </ul>
</section>
```

---

## CSS Classes Reference

| Class | Purpose | Background Color |
|-------|---------|------------------|
| `.learning-objectives` | What you'll learn | Light green |
| `.why-it-matters` | Real-world relevance | Light blue |
| `.vocabulary` | Key terms | Light yellow |
| `.self-check` | Review questions | Light pink |
| `.troubleshooting` | Problem solutions | Light red |
| `.key-concepts` | Summary takeaways | Green |
| `.common-mistakes` | Errors to avoid | Yellow warning |
| `.pro-tips` | Advanced hints | Blue |
| `.builds-on` | Prerequisites | Purple |
| `.challenge` | Stretch activities | Orange |
| `.try-it` | Hands-on practice | Cyan |
| `.expected-output` | Result preview | Gray |

---

## Quick Checklist

Before publishing any page, verify:

- [ ] Has `<meta name="description">`
- [ ] Has `<meta name="viewport">`
- [ ] Wrapped in `<div class="container">`
- [ ] Has learning objectives
- [ ] Has "Why it matters" context
- [ ] Code examples run as-is in GEE
- [ ] Code uses correct scale/offset
- [ ] Has self-check questions
- [ ] Has footer with home link
- [ ] Images have descriptive alt text
- [ ] All internal links work
- [ ] ASCII-clean (no curly quotes in code)

---

*Last Updated: December 2024*
