# Read the entire CSS file
$cssPath = 'E:\jackson\Joburg\css\styles.css'
$content = Get-Content $cssPath -Raw

# Remove all corrupted PowerShell script blocks that were incorrectly inserted
# Pattern: "param($match)" followed by PowerShell code blocks
$patterns = @(
    'param\(\$match\)\s*\$value = \[double\]\$match\.Groups\[1\]\.Value\s*\$unit = \$match\.Groups\[2\]\.Value.*?return "font-size: \$\{newValue\}\$\{unit\}"\s*;?',
    'param\(\$match\)\s*\r?\n\s*\$value.*?\{newValue\}.*?;',
    'param\(\$match\)[\s\S]*?(?=\n\n|\Z)'
)

foreach ($pattern in $patterns) {
    $content = [regex]::Replace($content, $pattern, '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
}

# Also clean any remaining fragments
$content = $content -replace 'param\(\$match\)[\s\S]*?\{newValue\}.*?;', ''
$content = $content -replace '\n\s*\n\s*\n', "`n`n"

Set-Content $cssPath -Value $content
Write-Host "Corrupted code removed from CSS."
