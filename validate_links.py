import os
import re
from urllib.parse import unquote, urlparse
from pathlib import Path

def validate_links(root_dir):
    root_path = Path(root_dir)
    html_files = list(root_path.rglob("*.html"))
    
    print(f"Scanning {len(html_files)} HTML files in {root_dir}...")
    
    broken_links = []
    checked_count = 0
    broken_count = 0
    
    # Regex to find href and src attributes
    link_pattern = re.compile(r'(?:href|src)=["\']([^"\']+)["\']')
    
    for file_path in html_files:
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            matches = link_pattern.findall(content)
            
            for link in matches:
                # Skip external links, anchors, and mailto
                if link.startswith(('http://', 'https://', 'mailto:', '#', 'javascript:')):
                    continue
                
                checked_count += 1
                
                # Handle anchors in internal links (e.g. file.html#section)
                url_parts = link.split('#')
                clean_link = url_parts[0]
                
                # If link is just an anchor (e.g. #top), parse skips it but split helps
                if not clean_link:
                    continue
                    
                # Decode URL characters (e.g. %20 -> space)
                decoded_link = unquote(clean_link)
                
                # Resolve path
                # Assuming links are relative to the file
                target_path = (file_path.parent / decoded_link).resolve()
                
                # Check existence
                if not target_path.exists():
                    # Try to handle root-relative paths if used (though unlikely in this struct)
                    # or just report it
                    broken_count += 1
                    broken_links.append({
                        'source': str(file_path.relative_to(root_path)),
                        'link': link,
                        'resolved_target': str(target_path)
                    })
                    
        except Exception as e:
            print(f"Error processing {file_path}: {e}")

    with open('links_report.txt', 'w', encoding='utf-8') as report_file:
        report_file.write(f"Scanning {len(html_files)} HTML files in {root_dir}...\n")
        report_file.write(f"\nChecked {checked_count} internal links.\n")
        report_file.write(f"Found {broken_count} broken links.\n")
        
        if broken_links:
            report_file.write("\n--- BROKEN LINKS REPORT ---\n")
            current_source = ""
            for item in broken_links:
                if item['source'] != current_source:
                    report_file.write(f"\nFile: {item['source']}\n")
                    current_source = item['source']
                report_file.write(f"  FAILED: {item['link']}\n")

if __name__ == "__main__":
    validate_links(r"c:\Users\sounn\Git\rsgee\rsgee")
