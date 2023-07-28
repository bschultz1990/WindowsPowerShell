function gn ($file) {
  if (-not $file) {
    Set-Clipboard ((Get-Item -Path $pwd).Name)
    Write-Host "Name copied!"
    return
  }
  Set-Clipboard ((Get-Item -Path $file).Name)
  Write-Host "Name copied!"
}
