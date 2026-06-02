$cssPath = 'E:\jackson\Joburg\css\styles.css'
$lines = Get-Content $cssPath

# Find lines that are just whitespace or braces but should have had font-size
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    # Look for patterns where font-size might be missing
    if ($line -match '^\s*\{?\s*$' -and $i -gt 0) {
        $prev = $lines[$i-1]
        if ($prev -match 'padding:\s*\d+px\s*\d+px\s*;' -or $prev -match 'color:\s*var\(--[a-z-]+\)\s*;') {
            # Potential missing font-size
            Write-Host "Line $($i+1): Possible missing property after: $($prev.Trim())"
        }
    }
}
