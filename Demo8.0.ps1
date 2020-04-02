#Demo8.0
Write-Host "Set laptop brightness to max" -ForegroundColor Green
Pause
. .\Set-MonitorBrighness-Function.ps1
Set-MonitorBrighness -Brightness 100
Write-Host "Sadly, you can't see the results..." -ForegroundColor Green
Pause
code .\Set-MonitorBrighness-Function.ps1