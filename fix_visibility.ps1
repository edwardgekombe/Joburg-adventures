# Fix visibility issues - ensure proper contrast

$cssFile = "css/styles.css"
$cssContent = Get-Content -Path $cssFile -Raw -Encoding UTF8

# Fix 1: Contact info icons in top header should be white (not black) for visibility on dark green background
$cssContent = $cssContent -replace '\.contact-info li a i \{[^}]*\}', '.contact-info li a i {
    color: var(--white);
    margin-right: 8px;
}'

# Fix 2: Ensure nav menu links are visible (dark text on white background)
$cssContent = $cssContent -replace '\.nav-menu a \{[^}]*\}', '.nav-menu a {
    font-weight: 700;
    font-family: var(--font-primary);
    color: var(--primary-black);
    position: relative;
    padding: 5px 0;
}'

# Fix 3: Ensure nav icons (social media) are visible
$cssContent = $cssContent -replace '\.nav-icons a \{[^}]*\}', '.nav-icons a {
    color: var(--primary-black);
}'

# Fix 4: Hero section text should be white/light for visibility
$cssContent = $cssContent -replace '\.hero-copy \{[^}]*\}', '.hero-copy {
    color: var(--white);
    max-width: 100%;
    margin: 0;
}'

# Fix 5: Ensure hero paragraph text is visible
$cssContent = $cssContent -replace '\.hero p \{[^}]*\}', '.hero p {
    color: rgba(255, 255, 255, 0.95);
    margin-bottom: 35px;
    max-width: 100%;
    margin-left: 0;
    margin-right: 0;
    font-size: 1.05rem;
}'

# Fix 6: Mobile logo should be visible
$cssContent = $cssContent -replace '\.mobile-logo \{[^}]*\}', '.mobile-logo {
    font-family: var(--font-secondary);
    font-weight: 700;
    color: var(--primary-black);
}'

# Fix 7: Ensure dropdown menu items are visible
$cssContent = $cssContent -replace '\.nav-menu \.dropdown-menu li\.sub-dropdown \.dropdown-item \{[^}]*\}', '.nav-menu .dropdown-menu li.sub-dropdown .dropdown-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 20px;
    font-size: 16px;
    font-weight: 700;
    font-family: var(--font-primary);
    color: var(--primary-black);
    transition: all 0.3s ease;
    border: 1.5px solid #ececec;
    border-radius: 14px;
    background: linear-gradient(135deg, #fafafa 0%, #f5f5f5 100%);
    gap: 12px;
    text-decoration: none;
    cursor: pointer;
}'

Set-Content -Path $cssFile -Value $cssContent -Encoding UTF8
Write-Host "Visibility issues fixed!" -ForegroundColor Green