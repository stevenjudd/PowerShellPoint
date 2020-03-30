function Start-PowerShellPoint {
    #add "slide x of y" to Window Title - Complete
    #fix math problem with the last space before the title wrap
    #fix lack of spaces for multi-line slide content

    param (
        [Parameter(Mandatory)]
        [string]$ContentPath,

        [switch]$ClearScreen
    )    

    # Write-Host "Starting..."
    $SlideContent = Import-Csv -Path $ContentPath
    #read the console sizes
    $height = $host.ui.RawUI.WindowSize.Height
    $width = $host.ui.RawUI.WindowSize.Width - 1
    if ($height -lt 10) {
        Write-Error "The console window height is too low for a good presentation. Please ensure its height is at least 10."
        Return
    }

    #check width of all titles
    foreach ($Slide in $SlideContent) {
        if ($Slide.Title.Length + 4 -gt $width * 2) {
            throw "Title length is too long for an effective presentation. Please use a shorter title: $Slide.Title"
        }
    }

    if ($ClearScreen) {
        Clear-Host
    }

    if ($GitPromptSettings.EnableWindowTitle) {
        $ResetGitPromptSetting = $GitPromptSettings.EnableWindowTitle
        $GitPromptSettings.EnableWindowTitle = $false
    }
    $InitialTitle = $host.ui.RawUI.WindowTitle
    $SlideNumber = 0

    if (($height % 2) -eq 0) {
        $middle = $height / 2
    }
    else {
        $middle = ($height - 1) / 2
    }

    foreach ($Slide in $SlideContent) {
        $SlideNumber++
        $host.ui.RawUI.WindowTitle = "Slide $SlideNumber of $($SlideContent.count)"
                
        Write-Host ("-" * $width)
        Write-Host ""
        
        if ($slide.title.Length + 2 -gt $width) {
            #find the last space before the $width (there are math problems here)
            $FirstTitleLine = $Slide.Title.Substring(0, $Slide.Title.Substring(0, $width - 2).LastIndexOf(" "))
            $SecondTitleLine = $Slide.Title.Substring($Slide.Title.Substring(0, $width - 2).LastIndexOf(" ") + 1)
            $TitleLineCount = 2
            Write-Host "  " $FirstTitleLine
            Write-Host "  " $SecondTitleLine
        }
        else {
            Write-Host "  $($slide.title)"
            $TitleLineCount = 1
        }
        
        Write-Host ""
        Write-Host ("-" * $width)
        $TitleLineCount += 4
        
        #determine the number of lines of content
        $ContentLineCount = 1
        $ContentCharacterCount = $Slide.Content.Length + 2
        while ($ContentCharacterCount / $width -gt 1) {
            $ContentLineCount++
            $ContentCharacterCount = $ContentCharacterCount - $width
        }
                
        #determine how many lines are left (should check at the top during content check)
        if ($height - $TitleLineCount - $ContentLineCount -lt 0) {
            throw "There is not enough space to present the content. Please use a larger window."
        }
        elseif (($height - $TitleLineCount - $ContentLineCount) % 2 -eq 0) {
            $LinesBeforeContent = ($height - $TitleLineCount - $ContentLineCount) / 2 
        }
        else {
            $LinesBeforeContent = ($height - $TitleLineCount - $ContentLineCount - 1) / 2
        }

        #add blank lines before the content
        for ($i = 1; $i -le $LinesBeforeContent; $i++) {
            Write-Host ""
        }

        #write the slide content (does not add the 2 spaces for multi-line content)
        Write-Host "  $($Slide.Content)"

        #Compute number of lines after content to bottom of console
        $linesLeft = $height - $TitleLineCount - $ContentLineCount - $LinesBeforeContent - 1
        for ($i = 1; $i -le $linesLeft; $i++) {
            Write-Host ""
        }
        Pause
        if ($Slide.command) {
            # Write-Host "$(prompt)" -NoNewline
            Write-Host "[Command]" -ForegroundColor Yellow -NoNewline
            Write-Host "PS> " -NoNewline
            $Slide.Content
            Pause
            # Write-Host "$(prompt)" -NoNewline
            Write-Host "[Results]" -ForegroundColor Green -NoNewline
            Write-Host "PS> " -NoNewline
            (Invoke-Expression "$($Slide.Content)" | more)
            Pause
        }
    } #end foreach($Slide in $SlideContent)

    $host.ui.RawUI.WindowTitle = $InitialTitle
    if ($ResetGitPromptSetting) {
        $GitPromptSettings.EnableWindowTitle = $ResetGitPromptSetting
    }
} #end function

#test case
Start-PowerShellPoint -ContentPath (Join-Path -Path $PSScriptRoot -ChildPath "SixGtSeven.csv")