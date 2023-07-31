function rename {
  param (
    [string]$file,
    [string]$destination
  )
  if (-not ("$destination")) {
    $destination = Read-Host "Enter a new name"
  }
  Rename-Item -Path "$file" -NewName "$destination"
}
