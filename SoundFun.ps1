$SoundFun = Join-Path -Path $env:TEMP -ChildPath "soundfun.exe"
Convert-TextToBinary -Text (Get-Content .\test.txt) -OutputPath $SoundFun
Invoke-Expression "$SoundFun mutesysvolume 0"
Invoke-Expression "$SoundFun setsysvolume 65535"
[System.Console]::Beep()