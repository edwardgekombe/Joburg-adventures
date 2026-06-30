# Fix button contrast and hero text visibility

$cssFile = "css/styles.css"
$cssContent = Get-Content -Path $cssFile -Raw -Encoding UTF8

# Fix 1: btn-primary should have white text on dark background (not black on black)
$cssContent = $cssContent -replace '\.btn-primary \{[^}]*\}', '.btn-primary {
    background-color: var(--primary-black);
    color: var(--white);
}'

# Fix 2: btn-primary hover should have good contrast
$cssContent = $cssContent -replace '\.btn-primary:hover \{[^}]*\}', '.btn-primary:hover {
    background-color: var(--accent-gold);
    color: var(--primary-black);
    transform: translateY(-2px);
    box-shadow: 0 5px 20px rgba(255, 140, 66, 0.4);
}'

# Fix 3: Ensure hero heading is visible
$cssContent = $cssContent -replace '\.hero-copy h1 \{[^}]*\}', '.hero-copy h1 {
    font-family: var(--font-secondary);
    font-weight: 800;
    font-size: clamp(2.8rem, 5vw, 4rem);
    line-height: 1.1;
    margin-bottom: 25px;
    color: var(--white);
}'

# Fix 4: Ensure hero stats numbers are visible
$cssContent = $cssContent -replace '\.hero-stats span \{[^}]*\}', '.hero-stats span {
    display: block;
    font-size: 2rem;
    font-weight: 700;
    color: var(--white);
    margin-bottom: 8px;
}'

# Fix 5: Ensure search heading is visible
$cssContent = $cssContent -replace '\.search-heading span \{[^}]*\}', '.search-heading span {
    display: block;
    font-weight: 700;
    font-size: 1rem;
    color: var(--white);
    margin-bottom: 8px;
}'

# Fix 6: Ensure page header h1 is visible
$cssContent = $cssContent -replace '\.header-content h1 \{[^}]*\}', '.header-content h1 {
    font-family: var(--font-secondary);
    font-weight: 700;
    color: var(--white);
    margin-bottom: 15px;
}'

Set-Content -Path $cssFile -Value $cssContent -Encoding UTF8
Write-Host "Button and text contrast fixed!" -ForegroundColor Green