function Set-MonitorBrighness {

    #Requires -PSEdition Desktop
    
    [CmdletBinding()]
    param (
        [ValidateRange(0, 100)]
        [int]$Brightness = 50
    )
    
    $mymonitor = Get-WmiObject -Namespace "root/wmi" -Class "WmiMonitorBrightnessMethods"
    $mymonitor.WmiSetBrightness(5, $brightness)
}

#compare the outputs:
# Get-WmiObject -Namespace root/wmi -class WmiMonitorBrightnessMethods | Get-Member
# Get-Ciminstance -Namespace root/WMI -ClassName WmiMonitorBrightness | Get-Member