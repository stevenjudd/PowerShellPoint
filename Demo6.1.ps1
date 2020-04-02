#Demo6.1
Write-Host "Open Mixer" -ForegroundColor Yellow
Pause
. .\Convert-TextToBinary-Function.ps1
.\SoundFun.ps1
Write-Host "Please check your volume..." -ForegroundColor Green
Pause
code .\SoundFun.ps1