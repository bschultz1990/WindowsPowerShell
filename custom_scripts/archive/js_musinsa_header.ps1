
function header($file) {
  while (-not $file) {
    $file = Read-Host "File not found. Please enter a different file name:"
  }
  $clause = "MUESTRA SIN VALOR COMERCIAL NO APTA PARA SU COMERCIALIZACION"
  $output = "$((Get-Item *$file*).Name)"
  Write-Host "Toutput: $output"
  cpdf -add-text $clause -topleft "18 48" -font "Helvetica" -font-size 8 (Get-Item *$file*) -o $output
  Copy-Item $output $dl
  open $output
}
