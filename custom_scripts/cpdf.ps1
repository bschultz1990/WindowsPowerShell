. $PSScriptRoot\vfpaths.ps1
. $PSScriptRoot\fileme.ps1

# cpdf -add-text "80.00 kg" -topleft "319 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' AND -add-text "90.00 kg" -topleft "442 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' -o out.pdf
# -match '(?<left>\d+)(?<decimal>,*\.*)(?<right>\d*)?'

function invoiceNums {
  $global:invoiceTable = [ordered]@{}

  # Ask the user for a list of invoice numbers. Compare it to the files in the present directory.
  $inv = Read-Host "Enter list of invoice numbers separated by a semicolon or 'q' to quit."
  if ($inv.ToLower() -eq "q") {
    return	
  }
  $global:inv = $inv.Split(";")
  Write-Host "Checking for invoice numbers..." -ForegroundColor DarkGray
  foreach ($i in $global:inv) {
    Write-Host "$i" -NoNewline

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

  # Display the results and ask for confirmation before continuing.
  Write-Host ""
  Write-Host "Invoice Table:"
  Write-Host ""
  Write-Host "Invoice Number Net Wt. Gross Wt."
  foreach ($i in $global:invoiceTable.Keys) {
    Write-Host "$i" -NoNewLine
    Write-Host " $($global:invoiceTable[$i]["Net Wt."])" -NoNewline
    Write-Host " $($global:invoiceTable[$i]["Gross Wt."])"
  }
  $response = Read-Host "Review carefully. Is this correct? [yes][no]"
  if ($response.ToLower() -eq "no") {
    return Write-Host "Aborted. Please try again with correct data." -ForegroundColor Yellow
  }

  # ACTIVATE FORWARD CPDF FIREPOWER!
  for ($i = 0; $i -lt $global:inv.Length; $i++) {
    Write-Host $global:inv[$i]
  }
}