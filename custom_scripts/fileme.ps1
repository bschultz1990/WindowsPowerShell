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
      Write-Host ""
    }
    else {
      Write-Host "Invalid input. Please enter 'yes' or 'no'."
    }
  }
  if (Test-Path -Path "./*VN*FORUS*.pdf" -PathType leaf) {
    Write-Host "Archiving VANS Forus to $vans_forus"
    Move-Item "*VN*FORUS*.pdf" $vans_forus
  }

  if (Test-Path -Path "./*JS*FORUS*.pdf" -PathType leaf) {
    Write-Host "Archiving VANS Forus to $jansport_forus"
    Move-Item "*JS*FORUS*.pdf" $jansport_forus
  }
  
  if (Test-Path -Path "./*KOMAX*SA *.pdf" -PathType leaf) {
    Write-Host "Archiving TNF Komax SA (Chile) to $tnf_komax_chile"
    Move-Item "*KOMAX*SA *.pdf" $tnf_komax_chile
  }

  if (Test-Path -Path "./*KOMAX*PERU *.pdf" -PathType leaf) {
    Write-Host "Archiving TNF Komax Peru to $tnf_komax_peru"
    Move-Item "*KOMAX PERU*.pdf" $tnf_komax_peru
  }

  if (Test-Path -Path "./SW*LOST ARROW*.pdf" -PathType leaf) {
    Write-Host "Moving Lost Arrow to $smartwool_lostarrow_edit"
    Move-Item "SW*LOST ARROW*.pdf" $smartwool_lostarrow_edit
  }

  if (Test-Path -Path "./*STARLIKE*.pdf" -PathType leaf) {
    Write-Host "Archiving SW Starlike to $smartwool_starlike_edit"
    Move-Item "*SW*STARLIKE*.pdf" $smartwool_starlike_edit
  }

  if (Test-Path -Path "./*VN*GRIMURU*.pdf" -PathType leaf) {
    Write-Host "Moving VANS Grimuru to $vans_grimuru_edit"
    Move-Item "*VN*GRIMURU*.pdf" $vans_grimuru_edit
    folderme $vans_grimuru_edit vans grimuru
  }

  if (Test-Path -Path "./*TNF*IMPORTADORA*.pdf" -PathType leaf) {
    Write-Host "Moving TNF COMERCIAL to $tnf_comercial_edit"
    Move-Item "*TNF*IMPORTADORA*.pdf" $tnf_comercial_edit
    folderme $tnf_comercial_edit tnf comercial
  }

  if (Test-Path -Path "./*VN*AREZZO*.pdf" -PathType leaf) {
    Write-Host "Moving VN Arezzo to $vans_arezzo_edit"
    Move-Item "*VN*AREZZO*.pdf" $vans_arezzo_edit
    folderme $vans_arezzo_edit vans arezzo
  }

  if (Test-Path -Path "./TNF*JUST*US*" -PathType leaf) {
    Write-Host "Moving TNF JUST US to $justus_edit"
    Move-Item "TNF*JUST*US*" $justus_edit
    folderme $justus_edit tnf justus
  }

  if (Test-Path -Path "./VN*GRIMOLDI*" -PathType leaf) {
    Write-Host "Moving VN GRIMOLDI" to $vans_grimoldi_edit
    Move-Item "VN*GRIMOLDI*" $vans_grimoldi_edit
    folderme $vans_grimoldi_edit vans grimoldi
  }

}
