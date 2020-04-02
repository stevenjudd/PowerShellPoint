Write-Host "go to https://icanhazdadjoke.com/api" -ForegroundColor Green
Write-Host "look at their API examples:" -ForegroundColor Green
Pause
curl -H "Accept: text/plain" https://icanhazdadjoke.com/
Write-Host "why does this work?" -ForegroundColor Green
Pause
ls \ curl.exe -r -ErrorAction SilentlyContinue | select fullname
Write-Host "yeah, but curl isn't PowerShell, therefore it sux. We want to use Invoke-WebRequest or Invoke-RestMethod" -ForegroundColor Green
Write-Host "but does anyone know how to convert a curl example?" -ForegroundColor Green
Pause
Find-Module curl*
Write-Host "the version looks a bit raw...let's take a closer look" -ForegroundColor Green
Pause
Find-Module curl* | select * | more
Write-Host "ThePoShWolf wrote it, therefore I trust it (right?). Thx Anthony!" -ForegroundColor Green
Pause
Install-Module Curl2PS -Scope CurrentUser
Write-Host "now convert the curl command (I'm cheating a bit here...)" -ForegroundColor Green
Pause
ConvertTo-IRM -CurlCommand 'curl -H "Accept: text/plain" https://icanhazdadjoke.com/' -String
Write-Host "take the output as the command" -ForegroundColor Green
Pause
Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain' }
Write-Host "now we have the command we need to put the dad joke in the windows title" -ForegroundColor Green
Pause
$Host.UI.RawUI.WindowTitle = Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain' }
Write-Host "if you have Posh-git either disable" -ForegroundColor Green
Pause
$GitPromptSettings.EnableWindowTitle = $false
Write-Host "or change to another directory that isn't a git repo" -ForegroundColor Green
Pause
cd C:\Users\steve\git\github\stevenjudd
Write-Host "Cool, but I want moar jokes!" -ForegroundColor Green