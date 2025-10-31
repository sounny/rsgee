# Remote Sensing with Google Earth Engine
## Digital Textbook & Lab Manual

A comprehensive, standalone educational resource for learning remote sensing and digital image processing using Google Earth Engine. This course was originally developed at the University of Florida and has been transformed into a modern, self-contained website free from Learning Management Systems.

---

## 📚 Course Overview

**Course Titles:**
- GIS 5038c Remote Sensing of Environment  
- GIS 4037 Digital Image Processing - Environmental Remote Sensing

**Description:**  
Remote Sensing is the art of digital image processing. It's a harmonious blend of cutting-edge technology and human wisdom, aiming to unravel the intricate layers of our planet. This course promotes a deeper understanding of the Earth's system and fosters an innovative approach to geographic studies. Students learn to use Google Earth Engine (GEE) and JavaScript to perform remote sensing analysis, image classification, and develop web applications for environmental monitoring.

---

## 🗂️ Repository Structure

```
rsgee/
├── index.html                 # Main course homepage with full schedule
├── css/
│   └── style.css             # Responsive design with hero banner
├── js/
│   └── (navigation scripts)  # Smooth scrolling, mobile menu
├── images/                   # Organized by topic
│   ├── animations/           # GIFs for environmental change
│   ├── diagrams/             # Classification diagrams, charts
│   ├── fire/                 # Fire monitoring images
│   ├── global-snow/          # Snow observatory visuals
│   ├── heat-islands/         # Urban heat island graphics
│   ├── javascript/           # Tutorial screenshots
│   ├── river-morphology/     # River analysis imagery
│   └── screenshots/          # GEE interface screenshots
├── labs/                     # 25 hands-on lab assignments
│   ├── lab-01-getting-started-with-gee.html
│   ├── lab-02-hello-landsat.html
│   ├── lab-03-js-basics.html
│   └── ... (through lab-20)
└── modules/                  # 57 educational content pages
    ├── future-directions/    # Future of remote sensing
    ├── research-methodology/ # Research design guide
    ├── supplementary/        # Additional resources
    ├── week-00-welcome/      # Getting started
    ├── week-01-javascript/   # JavaScript fundamentals
    ├── week-02-images/       # Image collections & manipulation
    ├── week-03-classification/ # Supervised & unsupervised
    ├── week-05-case-studies/ # Application overview
    ├── week-06-public-engagement/ # Science communication
    ├── week-07-river-morphology/  # Case study 1
    ├── week-08-global-snow-observatory/ # Case study 2
    ├── week-09-heat-islands/ # Case study 3
    └── week-10-fire/         # Case study 4
```

---

## 🎯 Course Content

### Core Skills (Weeks 0-6)
1. **Week 0: Welcome to Remote Sensing**
   - Getting started with Google Earth Engine
   - The Earth Engine API
   - Why JavaScript?
   - Earth from Space (NOVA documentary)

2. **Week 1: JavaScript Basics**
   - Variables, lists, objects, functions, comments
   - Introduction to additive color system
   - Labs: JS Basics, Night Lights

3. **Week 2: Image Collections & Manipulation**
   - Image collections, filtering, sorting
   - GEE Data Catalogs
   - Band arithmetic and spectral indices (NDVI)
   - Labs: Finding datasets, NDVI calculation, thresholds

4. **Week 3: Image Classification**
   - Discrete vs continuous data
   - Supervised vs unsupervised vs object-based
   - Land use vs land cover
   - History of classification
   - Labs: Supervised and unsupervised classification

5. **Week 4: Advanced Analysis**
   - Interoperability with ArcGIS Pro
   - Elevation modeling (SRTM data)
   - Zonal statistics (reducers)
   - Labs: Exporting data, visualizing terrain

6. **Week 5: Case Studies Introduction**
   - Overview of real-world RS applications
   - Labs: Health applications (malaria, environmental health)

7. **Week 6: Engaging with the Public**
   - Science communication principles
   - Creating animations and videos
   - Deploying GEE Apps
   - Labs: Making GIFs, building web applications

### Advanced Applications (Weeks 7-11)

**Week 7: River Morphology**
- Theory of fluvial geomorphology
- Creating river masks
- Centerline and width extraction
- Bank morphology analysis
- Multitemporal width changes
- Riverbank erosion detection

**Week 8: Global Snow Observatory**
- About MODIS data
- Creating and joining image collections
- Masking and reclassification
- Snow cover frequency calculation
- Trend analysis
- Visualization and dissemination

**Week 9: Urban Heat Islands**
- Land surface temperature derivation (MODIS & Landsat)
- Defining urban and rural references
- Calculating heat island intensity
- Spatial patterns and public health implications

**Week 10: Fire Monitoring**
- Fire detection theory
- MODIS and GOES fire datasets
- Case study: Bobcat Fire (California)
- Real-time monitoring systems
- UI/UX design for fire apps

**Week 11: Future Directions**
- Emerging technologies in remote sensing
- Machine learning and deep learning applications
- Comprehensive bibliography

### Special Modules

**Research Methodology**
- Developing research questions
- Formulating methodological approaches
- Stating hypotheses
- Broader impacts and context

**Supplementary Materials**
- Earth from Space (NOVA documentary guide)
- Further readings on classification and machine learning
- Academic resources and journals

---

## 🚀 Getting Started

### For Students

1. **Visit the Course Website**  
   Open `index.html` in your browser or visit the hosted URL

2. **Follow the [Course Schedule](index.html#schedule)**  
   - Start with Week 0 to set up your Earth Engine account
   - Progress through weekly modules sequentially
   - Complete labs to reinforce concepts

3. **Complete Labs in Order**  
   - Each lab builds upon previous knowledge
   - Step-by-step instructions with screenshots
   - Submit completed work as directed

4. **Engage with Case Studies**  
   - Weeks 7-10 feature in-depth real-world applications
   - Work through complete research workflows
   - Adapt methods to your own study areas

### For Instructors

1. **Customize the Course**  
   - Update contact information in `index.html`
   - Modify submission guidelines for your institution
   - Add or remove content as needed

2. **Host the Website**  
   - Works with any web server (GitHub Pages, Netlify, traditional hosting)
   - No server-side processing required
   - Pure HTML/CSS/JavaScript

3. **Adapt Content**  
   - All content uses semantic HTML
   - Consistent styling via `css/style.css`
   - Easy to add new labs or modules
   - Modular structure allows picking specific topics

---

## 🌐 Hosting Options

### GitHub Pages (Free - Recommended)
```bash
# 1. Push this repository to GitHub
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/rsgee.git
git push -u origin main

# 2. Enable GitHub Pages in repository settings
# Settings → Pages → Source: main branch
# Your site will be live at: https://yourusername.github.io/rsgee/
```

### Netlify (Free with Continuous Deployment)
```bash
# Option 1: Drag and drop to netlify.com/drop
# Option 2: Connect your GitHub repository for auto-deployment
```

### Local Development/Testing
```bash
# Open index.html directly in your browser
# Or use a local server:
cd rsgee
python -m http.server 8000
# Visit: http://localhost:8000
```

---

## 📧 Student Submission Guidelines

All lab assignments should be submitted via email with the following format:

**Submission:** Submit lab via email.
**Subject:** `Lab [Number] - [Assignment Name] - [Your Name]`

**Include:**
- Shareable link to your Google Earth Engine script
- Screenshots of your results
- Any code files or exported data (as attachments)
- Brief description of challenges encountered (optional)

---

## 🎨 Design Features

**Modern Responsive Design:**
- Full-width hero banner with call-to-action button
- Sticky navigation bar with mobile hamburger menu
- Clean card-based layout for modules
- Smooth scrolling and transitions
- Mobile-first responsive breakpoints

**Accessibility:**
- Semantic HTML5 markup
- ARIA labels for navigation
- High-contrast text
- Keyboard navigation support
- Screen reader friendly

**Visual Elements:**
- Professional color scheme with accent colors
- Organized tables with alternating rows
- Code blocks with monospace fonts
- Breadcrumb navigation on all pages
- Print-friendly layouts

---

## � Content Statistics

- **25 Lab Assignments** - Hands-on exercises with Earth Engine
- **57 Module Pages** - Theory, tutorials, and case studies
- **82 Total Educational Pages**
- **4 In-Depth Case Studies** - Real-world research workflows
- **13 Module Directories** - Organized by week and topic
- **7 Image Categories** - Fully organized visual resources

---

## �🛠️ Technologies Used

- **HTML5**: Semantic markup with accessibility features
- **CSS3**: Custom responsive design with flexbox and grid
- **JavaScript (Vanilla)**: Navigation, smooth scrolling, mobile menu
- **Google Earth Engine**: Primary analysis platform
- **No frameworks or dependencies**: Pure, lightweight code

---

## 📝 Migration & Development

### Successfully Migrated from Canvas LMS:
- ✅ All 25 lab assignments with screenshots
- ✅ Complete course schedule and structure
- ✅ 57 instructional content pages
- ✅ Images organized by topic (hundreds of files)
- ✅ External video and resource links
- ✅ Research methodology guidance
- ✅ Supplementary reading materials

### Removed/Not Included:
- ❌ Quizzes and exams (assessment content)
- ❌ Canvas-specific IDs and references
- ❌ LMS integration code
- ❌ Gradebook functionality
- ❌ Student roster information
- ❌ Semester-specific lecture recordings

### Enhancements Made:
- 🎨 Modern, responsive web design
- 📱 Mobile-optimized navigation
- 🗂️ Logical folder structure
- 🔗 Clean, semantic URLs
- 🎯 Improved accessibility
- 📧 Flexible submission system

---

## 🤝 Contributing

Contributions to improve this educational resource are welcome! Areas for enhancement:

- 📚 **Content Updates**: Keep pace with Earth Engine API changes
- 🖼️ **Screenshot Updates**: GEE interface evolves regularly
- 🌍 **New Examples**: Add contemporary environmental case studies
- ♿ **Accessibility**: Improve WCAG compliance
- 🌐 **Translations**: Make content available in other languages
- 📱 **Mobile UX**: Further optimize for small screens

---

## 📄 License & Attribution

**Educational Use:**  
This course material is provided for educational purposes. When using or adapting this content, please:

- Maintain attribution to the University of Florida Geography Department
- Respect Google Earth Engine Terms of Service
- Cite original authors when using course materials
- Share improvements with the community

**Original Course Development:**  
University of Florida, Department of Geography

---

## 🙏 Acknowledgments

- **University of Florida** - Original course development
- **Google Earth Engine Team** - Providing the analysis platform
- **Google Earth Engine Community** - Code examples and support
- **Dr. Sounny** - Course instructor and content creator
- **Open Source Community** - Tools and inspiration

---

## 📞 Contact & Support

**Course Content Questions:**  
Visit the course website for instructor contact information

**Technical Issues:**  
- Check browser console for JavaScript errors
- Ensure images are loading correctly
- Verify all links are working

**Google Earth Engine Help:**  
- [GEE Documentation](https://developers.google.com/earth-engine)
- [GEE Community Forum](https://groups.google.com/g/google-earth-engine-developers)
- [GEE Tutorials](https://developers.google.com/earth-engine/tutorials)

---

## 🚀 Deployment Status

**Current Version:** 1.0 (Production Ready)  
**Last Updated:** October 31, 2025  
**Status:** ✅ Complete and Deployed

### Completed:
- [x] All 25 labs converted and cleaned
- [x] All 57 module pages organized
- [x] Complete course schedule integrated
- [x] All images organized by topic
- [x] Responsive CSS with hero banner
- [x] Mobile navigation implemented
- [x] Character encoding fixed
- [x] All internal links validated
- [x] Research methodology module added
- [x] Supplementary materials included
- [x] Repository cleaned and organized

### Ready for:
- [ ] Deployment to production server
- [ ] Student enrollment
- [ ] Instructor customization
- [ ] Community contributions

---

**🎓 Ready to Learn Remote Sensing!** �️🌍

This comprehensive course provides everything needed to master remote sensing with Google Earth Engine, from basic JavaScript to advanced environmental applications.
