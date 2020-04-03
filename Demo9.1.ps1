#Demo9.1
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
drp "Copy the code for DadJokeTitleAndPrompt.ps1 and paste into the console"
drp "Then run some commands to see the command count increase,"
drp "which will also update the Dad Joke line and Window Title"
drp "code .\DadJokeTitleAndPrompt.ps1" -Command
drp 'Remember the $GitPromptSettings.EnableWindowTitle value or change to a non-git directory'