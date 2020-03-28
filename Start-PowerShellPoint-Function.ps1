function Start-PowerShellPoint {
    #add "slide x of y" to Window Title
    param (
        [string]$ContentPath,
        [switch]$ClearScreen
    )    

    $ErrorActionPreference = Continue
    if($ClearScreen){
        Clear-Host
    }

    $SlideContent = Import-Csv -Path $ContentPath
    $InitialTitle = $host.ui.RawUI.WindowTitle
    $SlideNumber = 0

    #read the console sizes
    $height = $host.ui.RawUI.WindowSize.Height
    if(($height % 2) -eq 0){
        $middle = $height / 2
    }
    else {
        $middle = ($height -1) / 2
    }
    $width = $host.ui.RawUI.WindowSize.Width - 1

    foreach($Slide in $SlideContent) {
        $SlideNumber++
        $host.ui.RawUI.WindowTitle = "Slide $SlideNumber of $($SlideContent.count)"
                
        Write-Host ("-" * $width)
        Write-Host ""
        
        if($Slide.Title.Length + 4 -gt $width * 2){
            throw "Title length is too long for an effective presentation. Please use a shorter title."
        }
        elseif($slide.title.Length + 2 -gt $width){
            #find the last space before the $width
            $FirstTitleLine = $Slide.Title.Substring(0,$Slide.Title.Substring(0,$width-2).LastIndexOf(" "))
            $SecondTitleLine = $Slide.Title.Substring($Slide.Title.Substring(0,$width-2).LastIndexOf(" ") + 1)
            $TitleLineCount = 2
            Write-Host "  " $FirstTitleLine
            Write-Host "  " $SecondTitleLine
        }
        else{
            Write-Host "$($slide.title)"
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
            $ContentCharacterCount - $width +2
        }
                
        #determine how many lines are left
        if($height - $TitleLineCount - $ContentLineCount -lt 0){
            throw "There is not enough space to present the content. Please use a larger window."
        }
        elseif(($height - $TitleLineCount - $ContentLineCount) % 2 -eq 0){
            $LinesBeforeContent = ($height - $TitleLineCount - $ContentLineCount) / 2 
        }
        else{
            $LinesBeforeContent = ($height - $TitleLineCount - $ContentLineCount - 1) / 2
        }

        #add blank lines before the content
        for ($i = 1; $i -le $LinesBeforeContent; $i++){
            Write-Host ""
        }

        #write the slide content
        Write-Host "  " $slide.Content

        #
        for ($i = 1; $i -lt [int](($linesLeft - [int]($slide.content.Length/ $host.UI.RawUI.WindowSize.Width))/2); $i++){
            Write-Host ""
        }
        Pause
        if($slide.command){
            Write-Host "$(prompt)" -NoNewline
            $Slide.Content
            Pause
            Write-Host "$(prompt)" -NoNewline
            (Invoke-Expression "$($slide.Content)" | more)
            Pause
        }
    } #end foreach($slide in $SlideContent)

    $host.ui.RawUI.WindowTitle = $InitialTitle
} #end function

#test case
Start-PowerShellPoint -ContentPath (Join-Path -Path $PSScriptRoot -ChildPath "SixGtSeven.csv")