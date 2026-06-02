$files = Get-ChildItem -Path 'E:\jackson\Joburg' -Filter *.html -File
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    if ($content -notmatch 'fonts\.cdnfonts\.com/css/gilroy') {
        $pattern = '<link[^>]*fonts\.googleapis\.com[^>]*rel=["'']stylesheet["''][^>]*>'
        $replacement = "`$0`n    <link href=`"https://fonts.cdnfonts.com/css/gilroy`" rel=`"stylesheet`">"
        $newContent = [regex]::Replace($content, $pattern, $replacement)
        Set-Content $file.FullName -Value $newContent
        Write-Host "Added Gilroy to" $file.Name
    } else {
        Write-Host "Already has Gilroy:" $file.Name
    }
}
