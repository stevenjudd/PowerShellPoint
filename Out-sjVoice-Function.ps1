Function Out-sjVoice {

    <#
        .SYNOPSIS 
            Use Windows operating system speech engine to output voice phrase
        .DESCRIPTION
            Use Windows operating system speech engine to output voice phrase
        .PARAMETER Phrase
            Phrase the speech engine will output
        .EXAMPLE
            Out-sjVoice -Phrase "This is a test"
            This command will read the phrase 'This is a test' using the 'David' voice.
        .NOTES
            Written by Steven Judd 03/03/2016
    #>

    [CmdletBinding()]

    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [string]
        $Phrase
    )

    Add-Type -AssemblyName System.speech
    Start-Sleep -Seconds 2
    $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $voices = $speak.GetInstalledVoices().voiceinfo


    If ($voices.name -eq "Microsoft David Desktop") {
        $selectedVoice = "Microsoft David Desktop"
    }
    elseIf ($voices.name -eq "Microsoft Hazel Desktop") {
        $selectedVoice = "Microsoft Hazel Desktop"
    }
    elseif ($voices.name -eq "Microsoft Anna") {
        $selectedVoice = "Microsoft Anna"
    }

    Add-Type -AssemblyName System.speech
    $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $speak.SelectVoice($selectedVoice)
    $speak.Speak($Phrase)


    $speak.Dispose()

} #end Out-sjVoice function