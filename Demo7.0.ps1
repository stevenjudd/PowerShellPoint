#Demo7.0
.\RickestOfRicks.ps1
Write-Host "Set volume back to normal" -ForegroundColor Green
Pause
. .\Set-SpeakerVolume-Function_v2.ps1
Set-SpeakerVolume -Level Mid
Pause
code .\RickestOfRicks.ps1