#from https://devblogs.microsoft.com/scripting/weekend-scripter-cheesy-script-to-set-speaker-volume/
#credit to Ed Wilson

Function Set-SpeakerVolume {
    Param (
        [switch]$min,
        [switch]$max
    )

    $wshShell = new-object -com wscript.shell

    if ($min)
    { 1..50 | % { $wshShell.SendKeys([char]174) } }
    ElseIf ($max)
    { 1..50 | % { $wshShell.SendKeys([char]175) } }
    Else
    { $wshShell.SendKeys([char]173) } 
}