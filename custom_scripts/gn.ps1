function gn {
  Set-Clipboard ((Get-Item -Path $pwd).Name)
    Write-Host "Name copied!"
}
