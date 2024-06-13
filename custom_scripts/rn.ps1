function rename {
  param (
    [string]$file,
    [string]$destination
  )
  $filename = $file -replace '^\.\\', ''
  Set-Clipboard $filename
  if (-not ("$destination")) {
    $destination = Read-Host "Enter a new name or 'q' to quit"
  }
  if ("$destination" -eq "q") {
    return $filename
  }
  Rename-Item -Path "$file" -NewName "$destination"
  Write-Host $destination -BackgroundColor Green -ForegroundColor Black
  return
}
