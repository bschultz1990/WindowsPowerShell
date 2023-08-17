function fileme {
	$confirmed = $false
	while ($confirmed -eq $false) {
		$response = Read-Host "Have you made sure there are no Starlike invoices that are USDC? (yes/no)"
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
	Write-Host "Archiving VANS Forus to $vans_forus"; Move-Item *VN*FORUS*.pdf $vans_forus
	Write-Host "Archiving TNF Komax SA (Chile) to $tnf_komax_chile"; Move-Item *KOMAX*SA*.pdf $tnf_komax_chile
	Write-Host "Moving SW Starlike to $smartwool_starlike"; Move-Item *SW*STARLIKE*.pdf $smartwool_starlike
}