function info ($file) {
  if ($file) {
    $name = (Get-Item $file).Name
    $extension = [System.IO.Path]::GetExtension($file)
    Write-Host "Name: $name"
    if (-not (Test-Path -Path $file -PathType Leaf)) {
      Write-Host "This is a directory."
      return
    }
    if ($extension) { Write-Host "Extension: $extension" }
    Write-Host "This is a file."
  }
}