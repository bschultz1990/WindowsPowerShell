. $PSScriptRoot\vfpaths.ps1
. $PSScriptRoot\fileme.ps1

# cpdf -add-text "80.00 kg" -topleft "319 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' AND -add-text "90.00 kg" -topleft "442 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' -o out.pdf
# -match '(?<left>\d+)(?<decimal>,*\.*)(?<right>\d*)?'

function invoiceNums {
  # if the backup directory doesn't exist, create one.
  if (-not (Test-Path backup)) {
    mkdir backup
  }
  Copy-Item *.pdf "./backup"

  # Ask the user for a list of invoice numbers. Compare it to the files in the present directory.
  $inv = Read-Host "Enter list of invoice numbers"
  $inv = $inv.Split(";")
  $global:ivalues = @()
  foreach ($i in $inv) {
    $global:ivalues += $i
  }
  Write-Host $global:ivalues
  Write-Host "Type: " -NoNewline
  Write-Host $global:ivalues.GetType().Name -ForegroundColor Green
}