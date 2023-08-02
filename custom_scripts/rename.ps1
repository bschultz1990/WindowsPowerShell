function rename {
  param (
    [string]$file,
    [string]$destination
  )
  if (-not ("$destination")) {
    $destination = Read-Host "Enter a new name or 'q' to quit"
  }
  if ("$destination" -eq "q") {
    return $file
  }
  Rename-Item -Path "$file" -NewName "$destination"
  return $destination
}
