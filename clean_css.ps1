# Clean up corrupted CSS from the scale_fonts.ps1 script
$cssPath = 'E:\jackson\Joburg\css\styles.css'
$content = Get-Content $cssPath -Raw

# Remove all the corrupted PowerShell script artifacts
$content = $content -replace 'param\(\$match\)\s*\r?\n\s*\$value = \[double\]\$match\.Groups\[1\]\.Value\s*\r?\n\s*\$unit = \$match\.Groups\[2\]\.Value\s*\r?\n\s*# Reduce by 15%.*?return "font-size: \$\{newValue\}\$\{unit\}"\s*;?', ''

# Now apply proper font scaling with a cleaner approach
$content = $content -replace 'font-size:\s*(\d+(?:\.\d+)?)(px|rem|em)', {
    param($match)
    $value = [double]$match.Groups[1].Value
    $unit = $match.Groups[2].Value
    # Reduce by 10% instead of 15% for more modest reduction
    $newValue = [math]::Round($value * 0.9, 1)
    if ($newValue -lt 1) { $newValue = 1 }
    return "font-size: ${newValue}${unit}"
}

Set-Content $cssPath -Value $content
Write-Host "CSS cleaned and scaled."
