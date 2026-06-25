# Get all HTML files
$files = Get-ChildItem -Path '.' -Filter '*.html' -File

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Add Book@ email after info@ in footer contact-info sections (list items)
    $content = $content -replace '(<a href="mailto:info@joburgadventures\.com"><i class="fas fa-envelope"></i> info@joburgadventures\.com</a>)', "`$1`n                            <li><a href=`"mailto:Book@joburgadventures.com`"><i class=`"fas fa-envelope`"></i> Book@joburgadventures.com</a></li>"
    
    # For footer sections that have different structure (div instead of li)
    $content = $content -replace '(<a href="mailto:info@joburgadventures\.com"><i class="fas fa-envelope"></i> info@joburgadventures\.com</a>)(\s*</div>)', "`$1`n                        <a href=`"mailto:Book@joburgadventures.com`"><i class=`"fas fa-envelope`"></i> Book@joburgadventures.com</a>`$2"
    
    # Update JSON-LD email field to include both emails
    $content = $content -replace '"email": "info@joburgadventures\.com"', '`"email`": `"info@joburgadventures.com, Book@joburgadventures.com`"'
    
    Set-Content $file.FullName $content -Encoding UTF8
    Write-Host Updated: $file.Name
}