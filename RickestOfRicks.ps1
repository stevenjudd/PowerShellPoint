Write-Host "Pump up the volume..." -ForegroundColor Green
Pause
. .\Convert-TextToBinary-Function.ps1 #need to add loading this function to SoundFun.ps1
.\SoundFun.ps1
Write-Host "Let's jam" -ForegroundColor Green
Pause
.\fun.ps1

<# the above effectively runs the following:
    $SoundFun = Join-Path -Path $env:TEMP -ChildPath "soundfun.exe"
    Convert-TextToBinary -Text (Get-Content .\SoundFun.txt) -OutputPath $SoundFun
    Invoke-Expression "$SoundFun mutesysvolume 0"
    Invoke-Expression "$SoundFun setsysvolume 65535"
    .\fun.ps1
#>