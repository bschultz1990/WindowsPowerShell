. $PSScriptRoot\vfpaths.ps1
. $PSScriptRoot\fileme.ps1

# cpdf -add-text "80.00 kg" -topleft "319 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' AND -add-text "90.00 kg" -topleft "442 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' -o out.pdf
# -match '(?<left>\d+)(?<decimal>,*\.*)(?<right>\d*)?'

function invoiceNums {
  $global:invoiceTable = [ordered]@{}

  # Create backup directory silently if there is none
  if (-not (Test-Path backup)) {
    $null = mkdir backup
  }

  # Ask the user for a list of invoice numbers. Compare it to the files in the present directory.
  $inv = Read-Host "Enter list of invoice numbers separated by a semicolon or 'q' to quit. e.g.: 10.00;20.00"
  if ($inv.ToLower() -eq "q") {
    return	
  }
  $global:inv = $inv.Split(";")
  Write-Host "Checking for invoice numbers..." -ForegroundColor DarkGray
  foreach ($i in $global:inv) {
    Write-Host "$i" -NoNewline
    res
    if (-not (Test-Path -Path *$i*.pdf -PathType leaf) -or $i -eq "") {
      Write-Host " Not Found! " -ForegroundColor Red
      return Write-Host "One or more invoices were not found. Double-check your files and/or omit a semicolon from the end." -ForegroundColor Red
    }

    if (Test-Path -Path *$i*.pdf -PathType leaf) {
      Write-Host " Found! " -ForegroundColor Green -NoNewline
      Write-Host (Get-Item *$i*).Name -ForegroundColor DarkGray
      # Add an inner ordered dictionary with invoice number for later
      $global:invoiceTable["$i"] = [ordered]@{
        "Net Wt."   = $null
        "Gross Wt." = $null
      }
      # Quietly copy the file to the backup directory
      $null = Copy-Item *$i* backup
    }
  }
  Write-Host ""

  $netWtString = Read-Host "Enter net weights separated by a semicolon or press 'q' to quit."
  if ($netWtString.ToLower() -eq "q") {
    return
  }
  # Split at ; and remove blanks
  $tempNetWt = $null
  $tempNetWt = $netWtString.Split(";")

  foreach ($i in $tempNetWt) {
    $i = $i.Replace(",", ".")
    $i = "{0:F2}" -f [float]$i
    $i += " kg"
  }

  $global:netWt = $tempNetWt
  Write-Host ""

  $grossWtString = Read-Host "Enter gross weights separated by a semicolon or 'q' to quit."
  if ($grossWtString.ToLower() -eq "q") {
    return
  }
  # Split at ; and remove blanks
  $tempGrossWt = $null
  $tempGrossWt = $grossWtString.Split(";")

  foreach ($i in $tempGrossWt) {
    $i = $i.Replace(",", ".")
    $i = "{0:F2}" -f [float]$i
    $i += " kg"
  }

  $global:grossWt = $tempGrossWt

  # Abort if net weight and gross weight length are not equal.
  if ($global:netWt.Length -ne $global:grossWt.Length) {
    Write-Host "Aborted. You must have the same number of net weights and gross weights. See below for details:" -ForegroundColor Red
    Write-Host -NoNewline "Net Wt. Entries: "
    Write-Host $global:netWt.Length -ForegroundColor DarkGray
    for ($i = 0; $i -lt $global:netWt.Length; $i++) {
      Write-Host "$i $($global:netWt[$i])"
    }

    Write-Host -NoNewline "Gross Wt. "
    Write-Host $global:grossWt.Length -ForegroundColor DarkGray
    for ($i = 0; $i -lt $global:grossWt.Length; $i++) {
      Write-Host "$i $($global:grossWt[$i])"
    }
    return
  }

  # Assign values to invoiceTable:
  for ($j = 0; $j -lt $global:netWt.Length; $j++) {
    $invoiceNumber = $global:inv[$j]
    $global:invoiceTable[$invoiceNumber]["Net Wt."] = $global:netWt[$j]
    $global:invoiceTable[$invoiceNumber]["Gross Wt."] = $global:grossWt[$j]
  }

  manual_confirm
  cpdf_weights
}

function manual_confirm {
  # Display the results and ask for confirmation before continuing.
  Write-Host ""
  Write-Host "Invoice Table:"
  foreach ($i in $global:invoiceTable.Keys) {
    Write-Host "$i" -NoNewLine
    Write-Host " Net: " -NoNewLine -ForegroundColor DarkGray
    Write-Host "$($global:invoiceTable[$i]['Net Wt.'])" -NoNewline
    Write-Host " Gross: " -NoNewLine -ForegroundColor DarkGray
    Write-Host "$($global:invoiceTable[$i]['Gross Wt.'])"
  }
  $response = Read-Host "Review carefully. Is this correct? [yes][no]"
  if ($response.ToLower() -eq "no") {
    return Write-Host "Aborted. Please try again with correct data." -ForegroundColor Yellow
  }

}
function cpdf_weights {
  foreach ($i in $global:invoiceTable.Keys) {
    $tnet = "$($global:invoiceTable[$i]['Net Wt.'])" + " kg"
    $tgross = "$($global:invoiceTable[$i]['Gross Wt.'])" + " kg"
    # $toutput = "$((Get-Item *$i*).BaseName)_weights.pdf"
    $toutput = "$((Get-Item *$i*).Name)"
    
    Write-Host $toutput
    cpdf -add-text $tnet -topleft "319 239" -font "Helvetica" -font-size 8 (Get-Item *$i*) AND -add-text $tgross -topleft "442 239" -font "Helvetica" -font-size 8 (Get-Item *$i*) -o $toutput
  }
}
