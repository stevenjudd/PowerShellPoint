#go to https://icanhazdadjoke.com/api
#look at their API examples:
curl -H "Accept: text/plain" https://icanhazdadjoke.com/
#why does this work?
ls \ curl.exe -r -ErrorAction SilentlyContinue | select fullname
#yeah, but curl isn't PowerShell, therefore it sux. We want to use Invoke-WebRequest or Invoke-RestMethod
#but does anyone know how to convert a curl example?
Find-Module curl*
#the version looks a bit raw...let's take a closer look
Find-Module curl* | select * | more
#ThePoShWolf wrote it, therefore I trust it (right?). Thx Anthony!
Install-Module Curl2PS -Scope CurrentUser
#now convert the curl command (I'm cheating a bit here...)
ConvertTo-IRM -CurlCommand 'curl -H "Accept: text/plain" https://icanhazdadjoke.com/' -String
#take the output as the command
Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain' }
#now we have the command we need to put the dad joke in the windows title
$Host.UI.RawUI.WindowTitle = Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain' }
#if you have Posh-git either disable
$GitPromptSettings.EnableWindowTitle = $false
#or change to another directory that isn't a git repo
cd C:\Users\steve\git\github\stevenjudd
