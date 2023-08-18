function fileme {
	$confirmed = $false
	while ($confirmed -eq $false) {
		Write-Host "=== IMPORTANT! Complete all of the following before continuing:===`n"
    "[ ] Remove all Starlike orders that are USDC`n"

    $response = Read-Host "Have you completed all of the above? (yes/no)"

		if ($response.ToLower() -eq 'no') {
			return
		}
		elseif ($response.ToLower() -eq 'yes') {
			$confirmed = $true
		}
		else {
			Write-Host "Invalid input. Please enter 'yes' or 'no'."
		}
	}
	Write-Host "Archiving VANS Forus to $vans_forus"
  Move-Item "*VN*FORUS*.pdf" $vans_forus
	
  Write-Host "Archiving TNF Komax SA (Chile) to $tnf_komax_chile"
  Move-Item "*KOMAX*SA *.pdf" $tnf_komax_chile

	Write-Host "Archiving TNF Komax Peru to $tnf_komax_peru"
  Move-Item "*KOMAX PERU*.pdf" $tnf_komax_peru

	Write-Host "Archiving SW Starlike to $smartwool_starlike"
  Move-Item *SW*STARLIKE*.pdf $smartwool_starlike

  Write-Host "Moving Lost Arrow to $smartwool_lostarrow_edit"
  Move-Item "*LOST ARROW*.pdf" $smartwool_lostarrow_edit

  Write-Host "Moving VANS Grimuru to $vans_grimuru_edit"
  Move-Item *VN*GRIMURU*.pdf $vans_grimuru_edit
  folderme $vans_grimuru_edit vans grimuru

  Write-Host "Moving TNF COMERCIAL to $tnf_comercial_edit"
  Move-Item *TNF*IMPORTADORA*.pdf $tnf_comercial_edit
  folderme $tnf_comercial_edit tnf comercial

  Write-Host "Moving VN Arezzo to $vans_arezzo_edit"
  Move-Item *VN*AREZZO*.pdf $vans_arezzo_edit
  folderme $vans_arezzo_edit vans arezzo
}
