# Update all favicon references to use the new logo

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Replace all favicon references with the new logo
    $content = $content -replace 'rel="icon" type="image/jpeg" href="Images/JOBURG NEW LOGO.png"', 'rel="icon" type="image/png" href="Images/JOBURG NEW LOGO.png"'
    $content = $content -replace 'rel="icon" type="image/png" href="Images/second favicon.png"', 'rel="icon" type="image/png" href="Images/JOBURG NEW LOGO.png"'
    $content = $content -replace 'rel="icon" type="image/jpeg" href="Images/Joburg Logo.jpg"', 'rel="icon" type="image/png" href="Images/JOBURG NEW LOGO.png"'
    
    # Write back to file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Updated favicon in: $($file.Name)"
}

Write-Host "`nAll favicons updated to use new logo!" -ForegroundColor Green