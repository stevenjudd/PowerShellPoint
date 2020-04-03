function drp {
    #short for display, run, pause
    param(
        [string]$Content,
        [switch]$Command
    )
    function WaitForKeypress {
        while ('13', '32', '40' -notcontains $KeyPress.VirtualKeyCode) {
            $KeyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
    }

    if (-not($Command)) {
        Write-Host $Content -ForegroundColor Green
        WaitForKeypress
    }
    else {
        # Write-Host "Command to run:" -ForegroundColor Green
        Write-Host "> $Content"
        WaitForKeypress
        Write-Host ""
        Invoke-Expression $Content
    }
}
Write-Host ""
Write-Host "Press spacebar, Enter, or Down to continue to the next line" -ForegroundColor DarkYellow
Write-Host ""

#begin explantion and commands
drp "Go to https://icanhazdadjoke.com/api"
drp "Look at their API examples and run the text only example (join in case the return is multi-line)"
drp '(curl -s -H "Accept: text/plain" https://icanhazdadjoke.com/) -join " "' -Command
drp "Why does this work?"
drp "Does PowerShell have curl?"
drp "Get-Command curl" -Command
drp "Yeah, but curl isn't PowerShell, therefore it sux. We want to use Invoke-WebRequest or Invoke-RestMethod"
drp "Does anyone know how to convert a curl example?"
drp "Let's look in the PowerShell Gallery (selecting the fields returned by default)"
drp 'while(-not($CurlResults)){$CurlResults = Find-Module curl* | Select Version,Name,Repository,Description};$CurlResults' -Command
drp "The version looks a bit raw...let's take a closer look"
drp 'while(-not($CurlResults)){$CurlResults = Find-Module curl*};$CurlResults | select * | more' -Command
drp "ThePoShWolf wrote it, therefore I trust it (right?). Thx Anthony!"
drp "Let's install into the current user's scope"
drp "Install-Module Curl2PS -Scope CurrentUser" -Command
drp "Get-Module Curl2PS -ListAvailable" -Command
drp "Convert the curl command (I'm cheating a bit here by knowing how to use the command...)"
drp "ConvertTo-IRM -CurlCommand 'curl -H `"Accept: text/plain`" https://icanhazdadjoke.com/`' -String" -Command
drp "Take the output as the command and test it (I converted it to one line)"
drp "Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain'}" -Command
drp "Now we have the command we need to put the dad joke in the windows title"
drp "Note that the next command should have different results since we are running the command again"
drp '$Host.UI.RawUI.WindowTitle = Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{"Accept" = "text/plain"}' -Command
drp "Check the console title bar. If you have Posh-git either disable it writing to the Window Title..."
drp '#if($GitPromptSettings){$GitPromptSettings.EnableWindowTitle = $false}' -Command
drp "Or change to another directory that isn't a git repo"
drp 'Push-Location $env:TEMP' -Command
drp "And witness the title of the console"
drp "Let's go back to where we were"
drp "Pop-Location" -Command
drp "Cool, but I want moar jokes!"
drp ".\Demo9.1.ps1" -Command

# comment
# execute