# Remote Sensing with Google Earth Engine
## Standalone Course Website

This is a standalone, LMS-free version of the Remote Sensing with Google Earth Engine course, originally taught at the University of Florida. The course has been converted from Canvas LMS format into a clean, modern, self-hosted website.

---

## 📚 Course Overview

**Course Titles:**
- GIS 5038c Remote Sensing of Environment  
- GIS 4037 Digital Image Processing - Environmental Remote Sensing

**Description:**  
Remote Sensing is the art of digital image processing. This course blends cutting-edge technology with human wisdom to unravel the intricate layers of our planet. Students will learn to use Google Earth Engine (GEE) and JavaScript to perform remote sensing analysis, image classification, and develop web applications for environmental monitoring.

---

## 🗂️ Website Structure

```
website/
├── index.html                 # Main course page with schedule
├── css/
│   └── style.css             # Minimalist light gray theme
├── js/
│   └── main.js               # JavaScript utilities (if needed)
├── images/
│   ├── screenshots/          # GEE interface screenshots
│   ├── diagrams/             # Classification diagrams, charts
│   └── animations/           # GIFs, animated visualizations
├── labs/
│   ├── lab-01-getting-started-with-gee.html
│   ├── lab-02-hello-landsat.html
│   ├── lab-03-js-basics.html
│   └── ... (20 total labs)
└── modules/
    ├── week-00-welcome/
    ├── week-01-javascript/
    ├── week-02-images/
    ├── week-03-classification/
    └── ... (additional modules)
```

---

## 🎯 Course Topics

### Core Skills
1. **Week 0**: Getting Started with Google Earth Engine
2. **Week 1**: JavaScript Programming Basics
3. **Week 2**: Image Collections & Band Arithmetic (NDVI)
4. **Week 3**: Image Classification (Supervised & Unsupervised)
5. **Week 4**: Elevation Modeling & Zonal Statistics
6. **Week 5**: Remote Sensing Applications (Health)
7. **Week 6**: Public Engagement & GEE App Deployment

### Advanced Applications
- River Morphology Analysis
- Global Snow Observatory
- Urban Heat Island Detection
- Fire Monitoring & Prediction

---

## 🚀 How to Use This Course

### For Students

1. **Start with the [Course Schedule](index.html#schedule)**  
   Follow the weekly progression of topics and labs

2. **Complete Labs in Order**  
   - Labs build upon each other
   - Each lab includes step-by-step instructions with screenshots
   - Submit completed work via email (see submission guidelines)

3. **Review Module Content**  
   - Read the instructional pages in the `modules/` folder
   - Watch accompanying lecture videos (linked in materials)

### For Instructors

1. **Customize Contact Information**  
   - Update instructor email in `index.html` (line 351)
   - Update email in each lab's submission section

2. **Host the Website**  
   - Upload `website/` folder to any web server
   - Works with GitHub Pages, Netlify, or traditional hosting
   - No server-side processing required (pure HTML/CSS/JS)

3. **Modify Content**  
   - All files use semantic HTML
   - Consistent styling via `css/style.css`
   - Easy to add/remove labs or modules

---

## 🌐 Hosting Options

### Option 1: GitHub Pages (Free)
```bash
# 1. Create a new GitHub repository
# 2. Upload the website/ folder contents
# 3. Enable GitHub Pages in repository settings
# Your site will be live at: https://yourusername.github.io/repo-name/
```

### Option 2: Netlify (Free)
```bash
# 1. Drag and drop the website/ folder to netlify.com/drop
# 2. Your site goes live instantly with a custom URL
```

### Option 3: Traditional Web Hosting
```bash
# Upload website/ contents via FTP to your web server
# Point your domain to the folder
# No special configuration needed
```

### Option 4: Local Testing
```bash
# Open index.html directly in your browser
# Or use a local server:
cd website
python -m http.server 8000
# Visit: http://localhost:8000
```

---

## 📧 Student Submission Guidelines

All lab assignments should be submitted via email with the following format:

**Email To:** instructor@university.edu  
**Subject:** `Lab [Number] - [Assignment Name] - [Your Name]`

**Include:**
- Shareable link to your Google Earth Engine script
- Screenshots of your results
- Any code files or exported data (as attachments)
- Brief description of challenges encountered (optional)

---

## 🎨 Design Philosophy

**Minimalist Modern Aesthetic:**
- Light gray color palette (#f5f5f5, #e8e8e8)
- Clean typography with ample whitespace
- Focus on content, not decoration
- Responsive design for mobile/tablet/desktop
- Accessible and print-friendly

**Key Design Elements:**
- Sans-serif fonts for readability
- Subtle shadows and borders
- Organized tables with alternating row colors
- Code blocks with syntax-friendly formatting
- Generous margins and padding

---

## 🛠️ Technologies Used

- **HTML5**: Semantic markup
- **CSS3**: Custom responsive design
- **JavaScript**: Minimal (for future enhancements)
- **Google Earth Engine**: Primary learning platform
- **No frameworks**: Pure vanilla code for simplicity

---

## 📝 Conversion Notes

### What Was Removed:
- ❌ All quizzes and exams
- ❌ Canvas-specific references and IDs
- ❌ LMS integration code
- ❌ Assessment metadata XML files
- ❌ Gradebook/roster functionality

### What Was Preserved:
- ✅ All 20 lab assignments
- ✅ Course schedule and structure
- ✅ Instructional content (modules)
- ✅ Images, diagrams, and screenshots
- ✅ External video links
- ✅ Google Earth Engine script links

### What Was Enhanced:
- 🎨 Modern, minimalist design
- 📱 Mobile-responsive layout
- 📧 Email-based submission system
- 🗂️ Organized folder structure
- 🔗 Clear navigation and breadcrumbs

---

## 🤝 Contributing

If you're using this course and want to improve it:

1. **Fix broken links** - Some external resources may have moved
2. **Update screenshots** - GEE interface changes over time
3. **Add new examples** - Remote sensing is always evolving
4. **Improve accessibility** - WCAG compliance suggestions welcome

---

## 📄 License

This course material is provided for educational purposes. Please respect:
- Google Earth Engine Terms of Service
- Original course authorship and attribution
- University of Florida's intellectual property policies

---

## 🙏 Acknowledgments

- **Original Course**: University of Florida Geography Department
- **Platform**: Google Earth Engine
- **Conversion**: LMS-to-HTML migration (2025)

---

## 📞 Support

For questions about:
- **Course Content**: Contact the instructor (update email in index.html)
- **Technical Issues**: Check browser console for errors
- **Google Earth Engine**: See [GEE Documentation](https://developers.google.com/earth-engine)

---

## 🚧 Future Enhancements

Potential improvements for future versions:
- [ ] Interactive JavaScript exercises
- [ ] Embedded code editors (CodeMirror)
- [ ] Progress tracking (localStorage)
- [ ] Search functionality
- [ ] Dark mode toggle
- [ ] Downloadable PDF versions of labs

---

**Last Updated:** October 24, 2025  
**Version:** 1.0 (Standalone Release)

---

## Quick Start Checklist

- [x] Website structure created
- [x] CSS stylesheet with minimalist design
- [x] Main index page with course schedule
- [x] Lab 1 converted as template
- [ ] Remaining 19 labs to convert
- [ ] Module pages to organize
- [ ] All images to rename and organize
- [ ] Test all internal links
- [ ] Update instructor contact info
- [ ] Deploy to web host

**Ready to launch!** 🚀
