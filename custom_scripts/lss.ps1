function lss ($dir) {
  $results = Get-ChildItem *$dir* -recurse
  foreach ($match in $results) {
    Write-Host $match.FullName
  }
}
