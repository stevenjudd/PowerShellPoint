function Convert-TextToBinary {
    param
    (
        [Parameter(Mandatory)]
        [string]
        $Text,
        
        [Parameter(Mandatory)]
        [string]
        $OutputPath
    )
    
    $Bytes = [System.Convert]::FromBase64String($Text )
    [System.IO.File]::WriteAllBytes($OutputPath, $Bytes) 
}