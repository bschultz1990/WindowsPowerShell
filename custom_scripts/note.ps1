function note ($note) {
  while (-not $note) { $note = Read-Host "Note content" }
  Add-Content -Path notes.txt -Value (Get-Date -Format MM/dd:), $note`n
  Get-Content notes.txt
}
