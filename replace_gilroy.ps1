$pattern = 'https://fonts.cdnfonts.com/css/gilroy'
$replacement = 'https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap'
Get-ChildItem -Path . -Filter *.html -Recurse | ForEach-Object {
    $path = $_.FullName
    (Get-Content -Raw -Path $path) -replace $pattern, $replacement | Set-Content -Path $path -Force
    Write-Host "Updated: $path"
}
Write-Host "Done replacing Gilroy links with Google Fonts Poppins."