Function prompt {
    $origLastExitCode = $LASTEXITCODE

    if (Test-Path variable:/PSDebugContext) {   
        Write-Host "`n[DBG]: " -NoNewline
    }
    else {
        Write-Host "`n" -NoNewline
    }
    # --- cache the Dad joke value
    if (-not($global:DadJokeContent)) {
        $global:DadJokeContent = Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain' }
        $Host.UI.RawUI.WindowTitle = $global:DadJokeContent
    }
    # --- insert new Dadjoke every $JokeFrequency commands
    $JokeFrequency = 2
    if ((Get-History).count % $JokeFrequency -eq 0) {
        $global:DadJokeContent = Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Method Get -Headers @{'Accept' = 'text/plain' }
        $Host.UI.RawUI.WindowTitle = $global:DadJokeContent
    }
    # --- Do you _really_ want to see the Dad jokes?
    Write-Host ">>> $($global:DadJokeContent) <<<" -ForegroundColor Green

    #insert path
    Write-Host "$(Get-Location)" -NoNewline
    #insert Git info
    Write-VcsStatus
    #new line
    Write-Host ''
    #add history number
    $HistoryID = (Get-History).Id 
    if ($HistoryID) {
        Write-Host "[$(($HistoryID)[-1]+1)] " -NoNewline
    }
    else {
        Write-Host "[1] " -NoNewline
    }
    #Add username
    if ($env:username.ToLower() -match "[x,z]adm") {
        Write-Host "$env:username" -NoNewline -ForegroundColor Red -BackgroundColor Black
    }
    else {
        Write-Host "$env:username" -NoNewline -ForegroundColor Green -BackgroundColor Black
    }
    #add nested prompt level indicator
    Write-Host "$('>' * ($nestedPromptLevel + 1))" -NoNewline
    $LASTEXITCODE = $origLastExitCode
    #write a space at the end to draw the custom prompt
    ' '
} 
