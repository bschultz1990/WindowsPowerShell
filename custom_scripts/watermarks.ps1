function singlepage($pdfPath) {
	$dumpOutput = pdftk $pdfPath dump_data
	$pageCount = $dumpOutput | Select-String -Pattern "NumberOfPages" | ForEach-Object { $_.ToString().Split(':')[1].Trim() }
	if ($pageCount -eq "1") {
		return $true
	}
	return $false
}

# (Get-Item *.pdf).Count

function watermarks {
	if (-not (Test-Path originals)) { mkdir originals }
	if (-not (Test-Path temp)) { mkdir temp }
	Copy-Item -Path *.pdf -Destination originals

	foreach ($pdf in (Get-Item *.pdf)) {
		Write-Host "Watermarking $(Split-Path -Leaf $pdf)"
		
		if (singlepage $pdf) {
			Write-Host "Pdf has one page." -ForegroundColor Yellow -BackgroundColor Black
			pdftk $pdf background $wm_vans output wm.pdf
			Remove-Item -Path $pdf
			Rename-Item -Path wm.pdf -NewName $pdf
			continue
		}

		Write-Host "Removing last page from $pdf"
		pdftk $pdf cat 1-r2 output stripped.pdf

		Write-Host "Duplicating last page."
		pdftk $pdf cat end output temp.pdf

		Write-Host "Making watermark."
		pdftk temp.pdf background $wm_vans output wm.pdf

		Write-Host "Joining stripped.pdf and wm.pdf."
		pdftk stripped.pdf wm.pdf cat output $pdf

		Write-Host "Done!"
		if (stripped.pdf) { Move-Item -Path stripped.pdf -Destination temp -Force }
		if (temp.pdf) { Move-Item -Path temp.pdf -Destination temp -Force }
		if (wm.pdf) { Move-Item -Path wm.pdf -Destination temp -Force }
	}
}