# Update logo from "Joburg Logo.jpg" to "JOBURG NEW LOGO.png" across all HTML files
# and update CSS colors to match the new logo

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File

# Replace logo references in HTML files
foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Replace all occurrences of Joburg Logo.jpg with JOBURG NEW LOGO.png
    $content = $content -replace 'Joburg Logo\.jpg', 'JOBURG NEW LOGO.png'
    
    # Write back to file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Updated: $($file.Name)"
}

Write-Host "`nLogo replacement complete!" -ForegroundColor Green

# Update CSS file with new color scheme based on the logo
$cssFile = "css/styles.css"
$cssContent = Get-Content -Path $cssFile -Raw -Encoding UTF8

# The new logo has:
# - Dark green/black for main elements
# - Orange to yellow gradient in elephant
# - Light green for "ADVENTURES" text

# Update CSS variables
$cssContent = $cssContent -replace '--primary-black: #1a1a1a;', '--primary-black: #0d3d2d;'
$cssContent = $cssContent -replace '--primary-gold: #D4A017;', '--primary-gold: #FF8C42;'
$cssContent = $cssContent -replace '--primary-yellow: #F5C518;', '--primary-yellow: #FFB800;'
$cssContent = $cssContent -replace '--accent-gold: #FFB800;', '--accent-gold: #FF6B35;'
$cssContent = $cssContent -replace '--dark-gray: #2d2d2d;', '--dark-gray: #1a1a1a;'

# Add new green color variable for ADVENTURES text
$cssContent = $cssContent -replace '(--accent-gold: #FF6B35;)', "`$1`n    --primary-green: #4a7c59;"

# Update logo text colors - JOBURG text (keep dark)
$cssContent = $cssContent -replace 'color: var\(--primary-gold\);', 'color: var(--primary-black);'

# Update ADVENTURES text to use green
$cssContent = $cssContent -replace '\.logo-text \.adventures \{', '.logo-text .adventures {'
$cssContent = $cssContent -replace 'color: var\(--primary-black\);', 'color: var(--primary-green);'

# Update hover states and other gold references to orange
$cssContent = $cssContent -replace 'rgba\(212, 160, 23,', 'rgba(255, 140, 66,'

# Update gradient backgrounds that use gold
$cssContent = $cssContent -replace 'linear-gradient\(135deg, rgba\(212, 160, 23, 0\.95\), rgba\(255, 184, 0, 0\.95\)\)', 'linear-gradient(135deg, rgba(255, 140, 66, 0.95), rgba(255, 184, 0, 0.95))'

# Update box shadows with gold colors
$cssContent = $cssContent -replace 'rgba\(212, 160, 23, 0\.4\)', 'rgba(255, 140, 66, 0.4)'
$cssContent = $cssContent -replace 'rgba\(212, 160, 23, 0\.14\)', 'rgba(255, 140, 66, 0.14)'
$cssContent = $cssContent -replace 'rgba\(212, 160, 23, 0\.2\)', 'rgba(255, 140, 66, 0.2)'
$cssContent = $cssContent -replace 'rgba\(212,160,23,0\.08\)', 'rgba(255,140,66,0.08)'

# Update hero highlight background
$cssContent = $cssContent -replace 'background: rgba\(212,160,23,0\.08\);', 'background: rgba(255,140,66,0.08);'
$cssContent = $cssContent -replace 'box-shadow: 0 6px 20px rgba\(212,160,23,0\.08\);', 'box-shadow: 0 6px 20px rgba(255,140,66,0.08);'

# Update contact intro gradient
$cssContent = $cssContent -replace 'background: linear-gradient\(135deg, var\(--primary-gold\) 0%, #c9972e 100%\);', 'background: linear-gradient(135deg, var(--primary-gold) 0%, #e67e22 100%);'

# Update service category why-choose gradient
$cssContent = $cssContent -replace 'background: linear-gradient\(135deg, var\(--primary-gold\) 0%, #c9972e 100%\);', 'background: linear-gradient(135deg, var(--primary-gold) 0%, #e67e22 100%);'

# Update destination overlay hover
$cssContent = $cssContent -replace 'background: linear-gradient\(to top, rgba\(212, 160, 23, 0\.9\) 0%, transparent 100%\);', 'background: linear-gradient(to top, rgba(255, 140, 66, 0.9) 0%, transparent 100%);'

# Update contact section radial gradients
$cssContent = $cssContent -replace 'background: radial-gradient\(ellipse, rgba\(212, 160, 23, 0\.08\) 0%, transparent 70%\);', 'background: radial-gradient(ellipse, rgba(255, 140, 66, 0.08) 0%, transparent 70%);'

# Update destination name color to match gold/orange
$cssContent = $cssContent -replace 'color: #FFD700;', 'color: var(--primary-gold);'

Set-Content -Path $cssFile -Value $cssContent -Encoding UTF8
Write-Host "CSS colors updated to match new logo!" -ForegroundColor Green

Write-Host "`nAll updates complete!" -ForegroundColor Cyan