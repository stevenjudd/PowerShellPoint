function Start-sjHeater {

    <#
    .NOTES
        PowerShell function written to generate heat
        Written by Steven Judd on 2016/12/14
        Credit for process priority: https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/lowering-powershell-process-priority
        Version 20200328
        Updated by Steven Judd on 2020/03/28:
            Run the process in low priority mode to not interfere with the operation of the computer
            Multi-threaded using Start-ThreadJob to use more CPU
            Added parameters for number of processes to start and process priority

        Add Features:
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
    .PARAMETER Jobs
        Specify the number of jobs to start. This number must be less than the
        number of Logical Processors on the local system. The default is 1.
    .PARAMETER Priority
        Specify the priority for the process. The options available are Idle, 
        BelowNormal, and Normal. The default is BelowNormal.
    .EXAMPLE
        Start-sjHeater -Cores 8 -Priority Normal
        Starting heater (CTRL+C to quit)...
        A "." will appear every minute the script is running.
    #>

    param(
        [ValidateScript( {
                if ($_ -le (Get-CimInstance Win32_Processor).NumberOfLogicalProcessors) {
                    $true
                }
                else {
                    Write-Error "More cores specified than available"
                }
            })]
        [int]$Jobs = 1,

        [ValidateSet("Normal", "BelowNormal", "Idle")]
        [string]$Priority = "BelowNormal"
    )

    if ((Get-CimInstance -ClassName Win32_OperatingSystem).Name -match "Server") {
        throw "This script is not intended for server operating systems"
    }

    #set the Process priority
    $InitialPriority = (Get-Process -Id $PID).PriorityClass
    (Get-Process -Id $PID).PriorityClass = $Priority

    ForEach ($item in 1..$Jobs) {
        Start-ThreadJob -Name "Heater$item" -ScriptBlock {
            while ($true) {
                #infinite loop
            }
        }
    }
    Write-Host "Starting heater (Press Spacebar to quit)" -ForegroundColor Yellow
    while ($KeyPress.VirtualKeyCode -ne 32) {
        $KeyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }

    Get-Job | Where-Object Name -match "^Heater" | Stop-Job -PassThru | Remove-Job
    (Get-Process -Id $PID).PriorityClass = $InitialPriority
} #end Start-sjHeater function

#test runs
# Start-sjHeater -Cores 2 -Priority BelowNormal
Start-sjHeater -Cores 8 -Priority Idle
# Start-sjHeater -Cores 8 -Priority BelowNormal
# Start-sjHeater -Cores 8 -Priority Normal