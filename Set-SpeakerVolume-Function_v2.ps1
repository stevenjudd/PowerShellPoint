#from https://devblogs.microsoft.com/scripting/weekend-scripter-cheesy-script-to-set-speaker-volume/
#credit to Ed Wilson
#modified by Steven Judd on 2020-03-30

Function Set-SpeakerVolume {
    Param (
        [ValidateSet("Min", "Max", "Mute", "Mid")]
        [string]$Level
    )

    $wshShell = New-Object -ComObject  wscript.shell
    switch ($Level) {
        "Min" { 1..50 | ForEach-Object { $wshShell.SendKeys([char]174) } }
        "Max" { 1..50 | ForEach-Object { $wshShell.SendKeys([char]175) } }
        "Mid" { 
            1..50 | ForEach-Object { $wshShell.SendKeys([char]174) }
            1..25 | ForEach-Object { $wshShell.SendKeys([char]175) }
        }
        "Mute" { $wshShell.SendKeys([char]173) } 
    }
} #end Set-SpeakerVolume function