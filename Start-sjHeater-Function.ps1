function Start-sjHeater {

    <#
.NOTES
    PowerShell function written to generate heat
    Written by Steven Judd on 2016/12/14
    Version 20161214
    Updated by [author] on [date]

    Add Features:
        Run the process in low priority mode to not interfere with the operation of the computer
        Check to see if the host is a non-local PC. No sense in generating heat where you can't feel it. ;)

.SYNOPSIS
    Runs the heater script to generate heat
.DESCRIPTION
    This is an infinite loop with on-screen output via Write-Host. It is
    intended to put a load on the CPU to cause the CPU to heat up and the
    CPU fan to come on to cool the CPU, thus generating heat. There is
    onscreen output to let the executor know that the script is running.
    This script will reduce the battery of a laptop due to the demand on
    the CPU and the fan.
.EXAMPLE
    Start-sjHeater
    Starting heater (CTRL+C to quit)...
    A "." will appear every minute the script is running.
#>

    if ((Get-CimInstance -ClassName Win32_OperatingSystem).Name -match "Server") {
        throw "This script is not intended for server operating systems"
    }

    #need a check to see if the PC is a virtual PC

    Write-Host "Starting heater (CTRL+C to quit)" -NoNewline
    $currentMinute = (Get-Date).Minute
    $i = 1
    while ($i -lt 2) {
        if ((Get-Date).Minute -ne $currentMinute) {
            $currentMinute = (Get-Date).Minute
            Write-Host "." -NoNewline
        }
    }

} #end Start-sjHeater function

#test runs
Start-sjHeater