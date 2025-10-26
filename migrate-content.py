#!/usr/bin/env python3
"""
Advanced Canvas Content Migration Script
Handles complex HTML parsing, image extraction, and content enhancement
"""

import os
import re
import json
from pathlib import Path
from html.parser import HTMLParser
import argparse

class CanvasContentExtractor(HTMLParser):
    """Extract and clean content from Canvas HTML exports"""
    
    def __init__(self):
        super().__init__()
        self.in_body = False
        self.content = []
        self.current_tag = None
        
    def handle_starttag(self, tag, attrs):
        if tag == 'body':
            self.in_body = True
            return
            
        if self.in_body:
            # Skip video links
            if tag == 'a':
                for attr, value in attrs:
                    if attr == 'href' and 'ufl.zoom.us' in value:
                        return
            
            # Build tag with attributes
            attr_str = ' '.join([f'{k}="{v}"' for k, v in attrs])
            self.content.append(f'<{tag} {attr_str}>' if attr_str else f'<{tag}>')
            self.current_tag = tag
    
    def handle_endtag(self, tag):
        if tag == 'body':
            self.in_body = False
            return
            
        if self.in_body and tag != 'a' or (tag == 'a' and self.current_tag == 'a'):
            self.content.append(f'</{tag}>')
            self.current_tag = None
    
    def handle_data(self, data):
        if self.in_body:
            # Skip lecture timestamps
            if 'Lecture - Fall' not in data and 'ufl.zoom.us' not in data:
                self.content.append(data)
    
    def get_content(self):
        html = ''.join(self.content)
        # Clean up excessive whitespace
        html = re.sub(r'\n\s*\n\s*\n+', '\n\n', html)
        # Remove empty paragraphs
        html = re.sub(r'<p>\s*</p>', '', html)
        # Fix image paths
        html = html.replace('$IMS-CC-FILEBASE$', '../../tobeworkedon/web_resources')
        return html.strip()

def load_content_mapping():
    """Load the content mapping configuration"""
    mapping = {
        # Week 0
        "welcome-to-remote-sensing.html": {
            "output": "week-00-welcome/welcome-to-remote-sensing.html",
            "week": "Week 0",
            "title": "Welcome to Remote Sensing"
        },
        "the-earth-engine-api.html": {
            "output": "week-00-welcome/earth-engine-api.html",
            "week": "Week 0",
            "title": "The Earth Engine API"
        },
        "why-javascript.html": {
            "output": "week-00-welcome/why-javascript.html",
            "week": "Week 0",
            "title": "Why JavaScript"
        },
        # Week 1
        "introduction-to-javascript.html": {
            "output": "week-01-javascript/introduction-to-javascript.html",
            "week": "Week 1",
            "title": "Introduction to JavaScript"
        },
        "variables.html": {
            "output": "week-01-javascript/variables.html",
            "week": "Week 1",
            "title": "Variables"
        },
        "lists.html": {
            "output": "week-01-javascript/lists.html",
            "week": "Week 1",
            "title": "Lists"
        },
        "objects.html": {
            "output": "week-01-javascript/objects.html",
            "week": "Week 1",
            "title": "Objects"
        },
        "functions.html": {
            "output": "week-01-javascript/functions.html",
            "week": "Week 1",
            "title": "Functions"
        },
        "comments.html": {
            "output": "week-01-javascript/comments.html",
            "week": "Week 1",
            "title": "Comments"
        },
        # Add more mappings as needed
    }
    return mapping

def create_page_template(title, week, content):
    """Generate HTML page with site template"""
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title} | Remote Sensing Course</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="../../index.html">Home</a> &gt; <a href="../../index.html#schedule">Schedule</a> &gt; {week}
        </nav>

        <header class="lab-header">
            <h1>{title}</h1>
        </header>

        <main class="lab-content">
{content}
        </main>

        <footer>
            <p><a href="../../index.html">← Back to Course Home</a></p>
            <p><strong>Remote Sensing with Google Earth Engine</strong></p>
        </footer>
    </div>
</body>
</html>
"""

def process_canvas_file(canvas_path, output_path, mapping):
    """Process a single Canvas HTML file"""
    print(f"Processing: {canvas_path.name}")
    
    try:
        with open(canvas_path, 'r', encoding='utf-8') as f:
            html_content = f.read()
        
        # Extract content
        parser = CanvasContentExtractor()
        parser.feed(html_content)
        content = parser.get_content()
        
        if not content:
            print(f"  ⚠ No content extracted")
            return False
        
        # Wrap content in section if not already wrapped
        if not content.startswith('<section'):
            content = f"            <section>\n{content}\n            </section>"
        else:
            # Indent properly
            content = '\n'.join(['            ' + line for line in content.split('\n')])
        
        # Generate full page
        page_html = create_page_template(
            mapping['title'],
            mapping['week'],
            content
        )
        
        # Create output directory
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Write file
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(page_html)
        
        print(f"  ✓ Created: {output_path}")
        return True
        
    except Exception as e:
        print(f"  ✗ Error: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Migrate Canvas content to website')
    parser.add_argument('--canvas-dir', default='tobeworkedon/wiki_content',
                       help='Canvas content directory')
    parser.add_argument('--output-dir', default='modules',
                       help='Output directory for website')
    parser.add_argument('--dry-run', action='store_true',
                       help='Show what would be done without making changes')
    parser.add_argument('--verbose', action='store_true',
                       help='Show detailed output')
    
    args = parser.parse_args()
    
    canvas_dir = Path(args.canvas_dir)
    output_dir = Path(args.output_dir)
    
    if not canvas_dir.exists():
        print(f"Error: Canvas directory not found: {canvas_dir}")
        return 1
    
    print("=== Canvas to Website Migration ===")
    print(f"Source: {canvas_dir}")
    print(f"Target: {output_dir}")
    
    if args.dry_run:
        print("\n[DRY RUN MODE - No files will be modified]\n")
    
    # Load mapping
    mapping = load_content_mapping()
    
    processed = 0
    skipped = 0
    
    for canvas_file, config in mapping.items():
        canvas_path = canvas_dir / canvas_file
        output_path = output_dir / config['output']
        
        if not canvas_path.exists():
            print(f"⚠ Source not found: {canvas_file}")
            skipped += 1
            continue
        
        if not args.dry_run:
            if process_canvas_file(canvas_path, output_path, config):
                processed += 1
            else:
                skipped += 1
        else:
            print(f"Would process: {canvas_file} -> {output_path}")
            processed += 1
        
        print()
    
    print("\n=== Summary ===")
    print(f"✓ Processed: {processed}")
    if skipped > 0:
        print(f"⚠ Skipped: {skipped}")
    
    if args.dry_run:
        print("\nRun without --dry-run to actually create files")
    
    return 0

if __name__ == '__main__':
    exit(main())
