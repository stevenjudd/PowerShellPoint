#Demo8.1
Write-Host "Install the Lumos module: Install-Module Lumos -Scope CurrentUser" -ForegroundColor Green
Get-Module Lumos
Pause
Invoke-Lumos -Dark
Pause
Invoke-Lumos -Light
Write-Host "You can read the help..." -ForegroundColor Green