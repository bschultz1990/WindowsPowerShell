function watermarks {
	if (-not (Test-Path originals)) { mkdir originals }
	Copy-Item -Path *.pdf -Destination originals
	foreach ($pdf in (Get-Item *.pdf)) {
		Write-Host "Watermarking $pdf"
		# Write-Host "Duplicating last page."
		pdftk $pdf cat end output temp.pdf

		# Write-Host "Removing last page from $pdf"
		pdftk $pdf cat 1-r2 output stripped.pdf

		# Write-Host "Making watermark."
		pdftk temp.pdf background $wm_vans output wm.pdf

		# Write-Host "Joining stripped.pdf and wm.pdf."
		pdftk stripped.pdf wm.pdf cat output $pdf

		# Write-Host "Cleaning..."
		Remove-Item -Path stripped.pdf, temp.pdf, wm.pdf
	}
}