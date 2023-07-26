function rename ($file) {
  $destination = Read-Host "Enter a new name"
    Rename-Item -Path "$file" -NewName "$destination"
}
