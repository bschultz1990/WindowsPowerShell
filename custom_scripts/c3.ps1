function c3 {
  $files = Get-ChildItem -Path .

  for ($i = 0; $i -lt $files.Count; $i++) {
    $item = $files[$i]
    $item | Add-Member -NotePropertyName "index" -NotePropertyValue $i
  }

  Access the files with assigned index numbers
  foreach ($item in $files) {
    Write-Host "$($item.Index) $($item.Name)"
  }
}