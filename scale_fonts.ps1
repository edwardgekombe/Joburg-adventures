$cssPath = 'E:\jackson\Joburg\css\styles.css'
(Get-Content $cssPath -Raw) -replace 'font-size:\s*(\d+(?:\.\d+)?)(px|rem|em)', {
    param($match)
    $value = [double]$match.Groups[1].Value
    $unit = $match.Groups[2].Value
    # Reduce by 15% (multiply by 0.85) and round
    $newValue = [math]::Round($value * 0.85, 1)
    # Ensure at least 1 for tiny sizes
    if ($newValue -lt 1) { $newValue = 1 }
    return "font-size: ${newValue}${unit}"
} | Set-Content $cssPath

Write-Host "Font sizes scaled down by 15%."
