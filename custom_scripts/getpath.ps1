function getpath($file) {
  if (!$file) {
    Write-Host "Error: No source file provided."
      return
  }
  $dir = (Get-Item $file).DirectoryName
    $file = (Get-Item $file).Name
    $path = Join-Path $dir $file
    Set-Clipboard $path
}
