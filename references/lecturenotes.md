This guide serves as a comprehensive textbook companion to the "Google Earth Engine 101" workshop presented by Stace Maples of the Stanford Geospatial Center. It is structured to take you from absolute beginner concepts through to advanced geospatial analysis, mirroring the progression of the video.

---

# Part 1: Conceptual Foundations

### Lesson 1: What is Remote Sensing?
Before writing code, you must understand the nature of the data.
*   **The Concept:** Remote sensing is the science of obtaining information about objects or areas from a distance, typically from aircraft or satellites.
*   **The Data Structure:** Satellite data comes as **Images**. A digital image is a grid of **Pixels**.
*   **Pixels are Numbers:** To a computer, a picture is just a spreadsheet of numbers. A pixel value represents the amount of reflected electromagnetic energy.
    *   *Example:* A red sports car reflects high amounts of red energy and absorbs blue and green. A black car absorbs almost all visible energy (low values). A white car reflects all visible energy equally (high values).
*   **The Electromagnetic Spectrum:** Human eyes only see "Visible Light" (Red, Green, Blue). Satellites can see "Invisible Light," such as:
    *   **Near-Infrared (NIR):** Highly reflected by healthy vegetation.
    *   **Shortwave Infrared (SWIR):** Useful for distinguishing wet/dry earth and rocks.
    *   **Thermal:** Measures heat.

### Lesson 2: The RGB Model & False Color
Your computer screen displays color by mixing three channels of light: **R**ed, **G**reen, and **B**lue.
*   **True Color:** We put the Red satellite band in the Red channel, Green in Green, and Blue in Blue. This looks like a photograph.
*   **False Color:** We can "cheat" nature to analyze data.
    *   *The Trick:* If we map the **Infrared** band (which we can't see) to the **Red** channel on the screen, healthy vegetation (which reflects IR strongly) will appear bright red. This creates high contrast between plants, water, and urban areas.

### Lesson 3: Resolution (Spatial, Temporal, Radiometric)
*   **Spatial Resolution (Pixel Size):** The physical area on the ground represented by one pixel.
    *   *Analogy:* **Landsat** has 30-meter resolution. One pixel is roughly the size of a baseball diamond infield. **Commercial Satellites** (like Maxar) might have 30cm resolution, letting you count cars.
*   **Temporal Resolution (Cadence):** How often the satellite revisits the same spot.
    *   *Landsat:* Every 16 days.
    *   *Sentinel-2:* Every 5–10 days.
    *   *Planet:* Daily (using a swarm of small satellites).
*   **Radiometric Resolution:** The depth of information (0–255 vs 0–65000).

### Lesson 4: The Fourth Paradigm (Why Earth Engine?)
*   **The Old Way:** Search for an image $\rightarrow$ Download huge files (GBs) $\rightarrow$ Process on a local desktop $\rightarrow$ Wait weeks for results.
*   **The Earth Engine Way:** Keep the data (Petabytes of it) in the cloud. Send your **questions** (code) to the data. The processing happens on Google's servers (thousands of CPUs at once), and only the answer (the map tiles or charts) is sent back to your browser.

---

# Part 2: The Google Earth Engine Interface

**The Code Editor** is an Integrated Development Environment (IDE) in your browser.
1.  **Center Panel (Editor):** Where you write JavaScript code.
2.  **Bottom Panel (Map):** Where the geographic results are displayed.
3.  **Left Panel (Manager):**
    *   *Scripts:* Your saved code and examples.
    *   *Docs:* A searchable dictionary of all Earth Engine functions.
    *   *Assets:* Your personal uploaded data (Shapefiles, GeoTIFFs).
4.  **Right Panel (Output):**
    *   *Inspector:* Click the map to see pixel values at that point.
    *   *Console:* Where text/charts print out (like "Hello World").
    *   *Tasks:* Used to manage long-running exports (downloading data).

**Crucial Feature:** The **"Get Link"** button creates a unique URL for your script. This allows you to share your exact code snapshot with others for collaboration or troubleshooting.

---

# Part 3: Tutorials & Script Walkthroughs

*Note: In GEE JavaScript, lines starting with `//` are comments.*

### Tutorial 1: JavaScript Basics ("Hello World")
*   **Variables:** Use `var` to create containers for data.
    *   `var myNumber = 42;`
    *   `var myString = 'Hello World';`
*   **Printing:** Use `print()` to send info to the Console tab.
    *   `print(myString);`
*   **Best Practices:** End statements with a semicolon `;`. Use single quotes `'` for strings.

### Tutorial 2: Loading & Displaying Images
How to load an elevation dataset (SRTM) and forest change data (Hansen).
*   **Key Concept:** `ee.Image("ID")` loads a specific dataset.
*   **Map.addLayer:** The function to put data on the map.
    *   Syntax: `Map.addLayer(image, {visualization parameters}, 'Layer Name');`
*   **Visualization:** Raw data needs to be stretched to fit the screen's 0–255 color range.
    *   Example: Elevation ranges from -10m to 6500m. If you don't define `{min: 0, max: 3000}`, the image might look solid gray.
*   **Masking:** You can hide pixels you don't want.
    *   `image.updateMask(image)` uses the image itself to hide "0" value pixels (making them transparent).

### Tutorial 3: Computations on Images
Earth Engine allows math on every pixel simultaneously.
*   **The Slope Algorithm:** `ee.Terrain.slope(srtmImage)` calculates the slope for every pixel in the elevation model instantly.
*   **On-the-fly Processing:** As you pan/zoom the map, GEE recalculates the math only for the pixels currently on your screen.

### Tutorial 4: Spatial Reductions (Zonal Statistics)
How to calculate the average slope within a specific area (like the Grand Canyon).
*   **Geometry:** You draw a polygon on the map or import a shapefile.
*   **The Reducer:** `image.reduceRegion()` is the function.
    *   **Reducer:** `ee.Reducer.mean()` (Calculates the average).
    *   **Geometry:** The polygon to calculate inside.
    *   **Scale:** **CRITICAL STEP.** You must tell GEE what pixel size to use (e.g., `30` for 30 meters). If you don't specify scale, GEE guesses based on your zoom level, which alters the statistical result.

### Tutorial 5: Image Collections (Filtering)
Usually, you don't want *one* image; you want to search the archive (e.g., Landsat 8).
*   **ee.ImageCollection:** A stack of images over time.
*   **Filtering:** Narrow down the stack.
    *   `.filterDate('2017-01-01', '2017-12-31')`
    *   `.filterBounds(geometry)` (Only images touching your area).
    *   `.sort('CLOUD_COVER')` (Order them by clearest weather).
*   **Selection:** `.first()` selects the top image from the sorted stack.

### Tutorial 6: Compositing (The "Magic" of Clouds)
If you load a year of data, you have cloudy days and clear days. How do you make a perfect map?
*   **The Problem:** Single images have clouds and "seams" (edges).
*   **The Solution:** Use the **Median Reducer**.
    *   Code: `var cleanImage = collection.median();`
    *   *Logic:* Take the stack of pixels for one spot over a year. The bright pixels are clouds; the dark pixels are shadows. The "middle" (median) value pixel is usually the clear ground. This creates a seamless, cloud-free mosaic.

### Tutorial 7: Band Math (NDVI)
Calculating the Normalized Difference Vegetation Index (NDVI) to measure plant health.
*   **Formula:** $(NIR - Red) / (NIR + Red)$
*   **GEE Shortcut:** `image.normalizedDifference(['B5', 'B4'])`
*   **Result:** A value between -1 and 1. High values are dense green leaves; low values are rock/dirt; negative values are water.

### Tutorial 8: Charting over Time
Plotting how vegetation changes throughout a year at a specific point.
*   **Function:** `ui.Chart.image.series()`
*   **Inputs:**
    *   Image Collection (The stack of time).
    *   Region (The point/polygon).
    *   Reducer (e.g., Mean).
    *   Scale (30m).
*   **Result:** An interactive graph in the Console showing seasonality (greening up in spring, browning in winter).

### Tutorial 9: Classification (Machine Learning)
How to teach the computer to recognize Water, Forest, and Urban areas.
1.  **Training Data:** Manually drop points on the map.
    *   Label them: 0=Water, 1=Forest, 2=Urban.
    *   Merge them into a single `FeatureCollection`.
2.  **Sampling:** Overlay these points on the satellite image to extracting the reflectance values (Red, Green, Blue, NIR, SWIR) for each point.
3.  **Train the Classifier:**
    *   `ee.Classifier.smileCart()` (Classification and Regression Trees).
    *   `.train(trainingData, 'classLabel', inputBands)`
4.  **Classify:** Run the trained model over the whole image: `image.classify(classifier)`.
5.  **Result:** A new map where every pixel is assigned a class (0, 1, or 2).

### Tutorial 10: Exporting Data
Getting your map out of the browser.
*   **Function:** `Export.image.toDrive()`
*   **Parameters:**
    *   `image`: The result you calculated.
    *   `description`: File name.
    *   `scale`: Resolution (e.g., 30).
    *   `region`: The bounding box to clip (don't export the whole world by accident!).
*   **Execution:** The "Tasks" tab will light up orange. You must click "Run" in the Tasks tab to start the server-side export. The result appears in your Google Drive as a GeoTIFF.

---

# Part 4: Key Takeaways & "Rules of Thumb"

1.  **Client vs. Server:** The browser (Client) just displays the map and buttons. The Google Cloud (Server) does the math. You cannot mix browser JavaScript (like standard `Date` objects) with Server objects (like `ee.Date`) easily. Stick to `ee.` functions.
2.  **Scale Matters:** In GEE, scale is defined at the *output*. You must explicitly state the scale (e.g., 30 meters) when doing exports or calculations (`reduceRegion`), or GEE will guess based on your zoom level.
3.  **The Median Composite:** This is the most powerful basic tool for beginners. It removes clouds, shadows, and bad data simply by looking at a stack of images over time and picking the middle value.
4.  **Don't Download:** Analyze the data in the cloud. Only download the final, small result (the chart or the classified map).
5.  **Use the Docs:** The "Docs" tab on the left is your best friend. It lists every function and what arguments it requires.
6.  **Troubleshooting:** If you get stuck, click "Get Link" and share it on forums or Slack. Without the link, no one can see your code context.

# Part 5: Resources

*   **Google Earth Engine Signup:** [signup.earthengine.google.com](https://signup.earthengine.google.com)
*   **Data Catalog:** [developers.google.com/earth-engine/datasets](https://developers.google.com/earth-engine/datasets) (The "Amazon shopping" for data).
*   **Stanford Geospatial Center:** [gis.stanford.edu](https://gis.stanford.edu)