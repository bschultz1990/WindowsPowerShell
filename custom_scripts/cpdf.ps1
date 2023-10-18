. $PSScriptRoot\vfpaths.ps1
. $PSScriptRoot\fileme.ps1

# cpdf -add-text "80.00 kg" -topleft "319 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' AND -add-text "90.00 kg" -topleft "442 239" -font "Helvetica" -font-size 8 '.\VN V000103257 AREZZO INDUSTRIA E COMERCIO S A 3525131272 stamped.pdf' -o out.pdf
# -match '(?<left>\d+)(?<decimal>,*\.*)(?<right>\d*)?'

function invoiceNums {
	# # if the backup directory doesn't exist, create one.
	# if (-not (Test-Path backup)) {
	#   $null = mkdir backup
	# }
	# Copy-Item *.pdf "./backup"
	
	# Ask the user for a list of invoice numbers. Compare it to the files in the present directory.
	$inv = Read-Host "Enter list of invoice numbers separated by a semicolon"
	$global:inv = $inv.Split(";")
	Write-Host "Checking for invoice numbers..." -ForegroundColor DarkGray
	foreach ($i in $global:inv) {
		Write-Host "$i" -NoNewline
		if (-not (Test-Path -Path *$i* -PathType leaf)) {
			Write-Host " Not Found! " -ForegroundColor Red
		}
		if (Test-Path -Path *$i* -PathType leaf) {
			Write-Host " Found! " -ForegroundColor Green -NoNewline
			Write-Host (Get-Item *$i*).Name -ForegroundColor DarkGray
		}
	}
	Write-Host ""
	# $netWtString = Read-Host "Enter net weights for the invoices above in order, separated by a semicolon. e.g. 80.00;90.00"
	# $global:netWt = $netWtString.Split(";")

	# # Copy to a local variable so we can work with it inside the loop
	# $tempNetWt = @()
	# foreach ($i in $global:netWt) {
	# 	$tempNetWt += $i
	# }
	# for ($i = 0; $i -lt $netWt.Length; $i++) {
	# 	# replace commas with decimal points
	# 	$tempNetWt[$i] = $global:netWt[$i].Replace(",", ".")

	# 	# convert each weight to a number with two decimal places
	# 	$tempNetWt[$i] = "{0:F2}" -f [float]$global:netWt[$i]

	# 	# append kg
	# 	$tempNetWt[$i] += " kg"
		
	# }
	# $global:netWt = $tempNetWt
	# for ($j = 0; $j -lt $global:netWt.Length; $j++) {
	# 	Write-Host $global:netWt[$j] " "-ForegroundColor DarkGray -NoNewline
	# 	Write-Host $global:netWt[$j].GetType() -ForegroundColor Yellow
	# }
}