Function Out-sjVoice {

    # --- Added a requires line for WindowsPowerShell
    #Requires -PSEdition Desktop

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
            Updated by Steven Judd on 2020-03-30
    #>

    [CmdletBinding()]

    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Phrase,

        # --- Added a Voice parameter with ValidateSet
        [ValidateSet("Anna", "David", "Hazel", "Zira")]
        [string]$Voice = "David"
    )

    # --- Added error handling
    # --- What else could I do here?
    try {
        Add-Type -AssemblyName System.speech
        $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
        $InstalledVoices = $speak.GetInstalledVoices().voiceinfo
    }
    catch {
        throw "Unable to load the SpeechSynthesizer voices"
    }

    # --- Converted mulitple ElseIf statements to a switch
    switch ($Voice) {
        "Anna" { $selectedVoice = "Microsoft Anna Desktop" }
        "David" { $selectedVoice = "Microsoft David Desktop" }
        "Hazel" { $selectedVoice = "Microsoft Hazel Desktop" }
        "Zira" { $selectedVoice = "Microsoft Zira Desktop" }
        Default {
            #not required due to ValidateSet
            throw "Unable to find a matching installed voice"
        }
    }

    # --- Removed redundant code
    # --- Added a check to see if the selected voice was installed
    if ($InstalledVoices.Name -contains $selectedVoice) {
        $speak.SelectVoice($selectedVoice)
        $speak.Speak($Phrase)
    }
    else {
        Write-Error "Selected voice is not installed"
    }

    $speak.Dispose()

} #end Out-sjVoice function

#test cases
# Out-sjVoice -Phrase "that pays"
# Out-sjVoice -Phrase "that pays" -Voice Zira
# Out-sjVoice -Phrase "that pays" -Voice Hazel
