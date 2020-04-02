#Demo6.0
Write-Host "Open Mixer" -ForegroundColor Yellow
Pause
. .\Set-SpeakerVolume.ps1
Write-Host "Turn sound off" -ForegroundColor Green
Set-SpeakerVolume -min
Pause
Write-Host "Turn sound to max" -ForegroundColor Green
Set-SpeakerVolume -max
Pause
Write-Host "Mute sound" -ForegroundColor Green
Set-SpeakerVolume
Pause
Write-Host "Unmute sound" -ForegroundColor Green
Set-SpeakerVolume
Write-Host "What if we made it better..." -ForegroundColor Yellow
Pause
code .\Set-SpeakerVolume-Function_v2.ps1
code .\Set-SpeakerVolume.ps1
. .\Set-SpeakerVolume-Function_v2.ps1