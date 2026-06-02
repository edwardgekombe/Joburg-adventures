$htmlFiles = Get-ChildItem -Path 'E:\jackson\Joburg' -Filter *.html -File
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    # Check if the override is already added
    if ($content -notmatch 'typography-overrides\.css') {
        # Add after the link to styles.css
        $newContent = $content -replace '(<link rel="stylesheet" href="css/styles\.css">)', "`$1`n    <link rel=`"stylesheet`" href=`"css/typography-overrides.css`">"
        Set-Content $file.FullName -Value $newContent
        Write-Host "Added override to" $file.Name
    } else {
        Write-Host "Already has override:" $file.Name
    }
}
