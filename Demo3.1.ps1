#Demo3.0
Write-Host "Load original version" -ForegroundColor Green
. .\Out-sjVoice-Function.ps1
Out-sjVoice -Phrase "Dave? What are you doing, Dave?"
Pause
Write-Host "Load newer version" -ForegroundColor Green
. .\Out-sjVoice-Function_v2.ps1
Out-sjVoice -Phrase "Dave? What are you doing, Dave?"
