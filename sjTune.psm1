# Module name: Start-sjTune
# Author: Matt Tisdale
# Version: 20151216.1
#
# This module was written purely for fun and to combine a few different hobbies.
# This module can be used to play any tune someone wants to take the time to configure.
# Anyone with a basic understanding of PowerShell and music theory can use the 
# examples below to add any desired tune.
# I reused code located here to complete this:  
# http://powershell.com/cs/blogs/tips/archive/2015/12/14/time-for-christmas.aspx


function Get-Frequency([string]$note) {
    # n is the number of half steps from the fixed note

    # --- Why does the following RegEx work for flats?
    $null = $note -match '([A-G#]{1,2})(\d+)'
    $octave = ([int] $matches[2]) - 4;
    $n = $octave * 12 + ( Get-HalfSteps $matches[1] );
    $f0 * [math]::Pow($a, $n);
} # END function Get-Frequency

function Get-HalfSteps([string]$note) {
    switch ($note) {
        'A' { 0 }
        'A#' { 1 }
        'Bb' { 1 }
        'B' { 2 }
        'C' { 3 }
        'C#' { 4 }
        'Db' { 4 }
        'D' { 5 }
        'D#' { 6 }
        'Eb' { 6 }
        'E' { 7 }
        'F' { 8 }
        'F#' { 9 }
        'Gb' { 9 }
        'G' { 10 }
        'G#' { 11 }
        'Ab' { 11 }
    } # END switch($note)
} # END function Get-HalfSteps

Function Start-sjTune {

    <#
.SYNOPSIS
    Plays a specific tune
.DESCRIPTION
    This function can be used to play any tune available in the code
.PARAMETER Song
    Name of the song to play
.EXAMPLE
    Start-sjTune ImperialMarch
    Play Star Wars Imperial March
#>

    Param (
        [parameter(Mandatory = $true)]
        [ValidateSet("ImperialMarch", "JingleBells", "Jeopardy")]
        [string]
        $Song
    ) # END Param

    If ($Song -eq "ImperialMarch") {
        # Star Wars Imperial March
        $StandardDuration = 1000
        $notes = @'
2G4 2G4 2G4 3Eb4 8Bb5 2G4 3Eb4 8Bb5 1G4
2D5 2D5 2D5 3Eb5 8Bb5 2Gb4 3Eb4 8Bb5 1G4
2G5 3G4 8G4 2G5 3Gb5 8F5 9E5 9Eb5 2.5E5 7Ab4 2Db5 3C5 8B5
9Bb5 9A5 2.5Bb5 7Eb4 2Gb4 3Eb4 8G4 2Bb5 3G4 8Bb5 1D5
2G5 3G4 8G4 2G5 3Gb5 8F5 9E5 9Eb5 2.5E5 7Ab4 2Db5 3C5 8B5
9Bb5 9A5 2.5Bb5 7Eb4 2Gb4 3Eb4 8Bb5 2G4 3Eb4 8Bb5 1G4 
'@
    } # END If ($Song -eq "Imperial March")

    elseif ($Song -eq "JingleBells") {
        $StandardDuration = 1000
        $notes = @'
4A4 4A4 2A4 4A4 4A4 2A4 4A4 4C4 4F3 4G3 1A4 4Bb4 4Bb4 4Bb4 4Bb4
4Bb4 4A4 4A4 8A4 8A4 4C4 4C4 4Bb4 4G3 1F3 4C3 4A4 4G3 4F3 1C3 8C3 8C3
4C3 4A4 4G3 4F3 1D3 4D3 4Bb4 4A4 4G3 1E3 4C4 4C4 4Bb4 4G3
1A4 4C3 4A4 4G3 4F3 1C3 4C3 4A4 4G3 4F3 1D3
4D3 4Bb3 4A4 4G3 4C4 4C4 4C4 8C4 8C4 4D4 4C4 4Bb4 4G3 1F3 
'@
    } # END elseif ($Song -eq "Jingle Bells")

    elseif ($Song -eq "Jeopardy") {
        $StandardDuration = 1500
        $notes = @'
4G4 4C5 4G4 4C4 4G4 4C5 2G4
4G4 4C5 4G4 4C5 3E5 8D5 8C5 8B5 8A5 8G#4
4G4 4C5 4G4 4C4 4G4 4C5 2G4
3C5 8A5 4G4 4F4 4E4 4D4 2C4
4Bb5 4Eb5 4Bb5 4Eb4 4Bb5 4Eb5 2Bb5
4Bb5 4Eb5 4Bb5 4Eb5 3G5 8F5 8Eb5 8D5 8C5 8B5
4Bb5 4Eb5 4Bb5 4Eb4 4Bb5 4Eb5 2Bb5
3Eb5 8C5 4Bb5 4Ab4 4G4 4Eb0 4F4 4Eb0 4Eb4 4Eb3 4Eb3
'@
    } # END elseif ($Song -eq "Jingle Bells")

    # Note is given by fn=f0 * (a)^n
    # a is the twelth root of 2
    # n is the number of half steps from f0, positive or negative
    # f0 used here is A4 at 440 Hz
    $f0 = 440
    $a = [math]::pow(2, (1 / 12)) # Twelth root of 2

    $notes.Split(' ') | ForEach-Object {
        if ($_ -match '(\d)(.+)') {
            $duration = $StandardDuration / ([int]$matches[1])
            $playNote = $matches[2]
            $freq = Get-Frequency $playNote
            [console]::Beep($freq, $duration)
            #Start-Sleep -Milliseconds 50
        } # END if ($_ -match '(\d)(.+)')
    } # END ForEach-Object

} # END Function

Export-ModuleMember -Function Start-sjTune

# Start-sjTune JingleBells