# Fix the overly broad color replacements

$cssFile = "css/styles.css"
$cssContent = Get-Content -Path $cssFile -Raw -Encoding UTF8

# Restore body text color to dark green/black
$cssContent = $cssContent -replace 'color: var\(--primary-green\);', 'color: var(--primary-black);'

# Now specifically target only the logo text elements
# Fix .logo-text .joburg to use dark green/black
$cssContent = $cssContent -replace '(\.logo-text \.joburg \{[^}]*?)color: var\(--primary-black\);', '${1}color: var(--primary-black);'

# Fix .logo-text .adventures to use green
$cssContent = $cssContent -replace '(\.logo-text \.adventures \{[^}]*?)color: var\(--primary-black\);', '${1}color: var(--primary-green);'

# Fix footer logo text
$cssContent = $cssContent -replace '(\.footer-about \.logo-text \.joburg \{[^}]*?)color: var\(--primary-gold\);', '${1}color: var(--primary-black);'
$cssContent = $cssContent -replace '(\.footer-about \.logo-text \.adventures \{[^}]*?)color: #fff;', '${1}color: var(--primary-green);'

Set-Content -Path $cssFile -Value $cssContent -Encoding UTF8
Write-Host "Colors fixed!" -ForegroundColor Green