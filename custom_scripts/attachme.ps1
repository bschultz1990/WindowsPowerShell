function attachme {
  
  if (-not (Test-Path backup)) {
    New-Item -Path . -Name "backup" -ItemType "directory" | Out-Null
  }
  
  # Remove duplicates
  Get-ChildItem -Path . -Filter "*[*" | Remove-Item

  # Remove any credit memos
  foreach ( $i in (Get-ChildItem -Filter "*#_7*")) {
    Remove-Item $i
  }

  # Check to see if eml-extractor is installed
  if (-not (Get-Command eml-extractor -ErrorAction SilentlyContinue)) {
    Write-Host "Installing eml-extractor..."
    pipx install eml-extractor
  }
  eml-extractor

  Move-Item *.eml ./backup
  foreach ($i in (Get-ChildItem . -Exclude backup)) {
    Move-Item $i/*.pdf .
    Remove-Item $i
  }
}