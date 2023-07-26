function mkdir ($dir) {
  New-Item -Path "." -Name "$dir" -ItemType "directory"
}
