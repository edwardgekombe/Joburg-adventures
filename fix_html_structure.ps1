# Fix malformed HTML where <li> tags were incorrectly added inside <div> elements
$files = Get-ChildItem -Path '.' -Filter '*.html' -File

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Fix the pattern where <li> was incorrectly added after an <a> tag inside a <div>
    $content = $content -replace '(<a href="mailto:info@joburgadventures\.com"><i class="fas fa-envelope"></i> info@joburgadventures\.com</a>)\s*<li><a href="mailto:Book@joburgadventures\.com"><i class="fas fa-envelope"></i> Book@joburgadventures\.com</a></li>', "`$1`n                        <a href=`"mailto:Book@joburgadventures.com`"><i class=`"fas fa-envelope`"></i> Book@joburgadventures.com</a>"
    
    Set-Content $file.FullName $content -Encoding UTF8
    Write-Host Fixed: $file.Name
}