# Remove .html extensions from all internal links in HTML files

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Replace href links that end with .html (but not external links)
    # Pattern: href="filename.html" -> href="filename"
    $content = $content -replace 'href="([^"]+)\.html"', 'href="$1"'
    
    # Also replace links with .html in the middle (like destination-diani.html)
    $content = $content -replace 'href="([^"]+?)\.html"', 'href="$1"'
    
    # Write back to file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Updated links in: $($file.Name)"
}

Write-Host "`nAll .html extensions removed from internal links!" -ForegroundColor Green