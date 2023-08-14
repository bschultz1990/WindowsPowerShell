function fileme {
    Write-Host "Moving VANS Forus"; Move-Item *VN*FORUS*.pdf $vans_forus
    Write-Host "Moving TNF Komax SA (Chile)"; Move-Item *KOMAX*SA*.pdf $tnf_komax_chile
}