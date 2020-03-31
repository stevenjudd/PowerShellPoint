function Convert-BinaryToText {
    param
    (
        [Parameter(Mandatory)]
        [string]
        $Path
    )
    
    $Bytes = [System.IO.File]::ReadAllBytes($Path )
    [System.Convert]::ToBase64String($Bytes)
}
