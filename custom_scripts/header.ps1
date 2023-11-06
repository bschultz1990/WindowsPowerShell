
function header($file) {
  while (-not $file) {
    $file = Read-Host "File not found. Please enter a different file name:"
  }
  # if (-not (Test-Path backup)) {
  #   $null = mkdir backup
  # }
  # Copy-Item *$file* backup
  # Write-Host "Copied $file to backup folder."
  $clause = "MUESTRA SIN VALOR COMERCIAL NO APTA PARA SU COMERCIALIZACION"
  $output = "$((Get-Item *$file*).Name)"
  Write-Host "Toutput: $output"
  cpdf -add-text $clause -topleft "18 48" -font "Helvetica" -font-size 8 (Get-Item *$file*) -o $output
  cp $output $dl
  open $output
}