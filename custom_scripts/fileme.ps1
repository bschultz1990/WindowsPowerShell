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

  function moveme ($path, $destination) {
      if (Test-Path -Path $path -PathType leaf) {
        Move-Item $path $destination -PassThru
      }
    }

  if (Test-Path -Path "./*ABDULWAHAB*.pdf" -PathType leaf) {
    Write-Host "Moving Ali Abdulwahab to $invoices/Ali Abdulwahab Al Mutawa"
    Move-Item "./*ABDULWAHAB*.pdf" "$invoices/Ali Abdulwahab Al Mutawa"
  }

  if (Test-Path -Path "./*VN*FORUS*.pdf" -PathType leaf) {
    Write-Host "Archiving VANS Forus to $vans_forus"
    Move-Item "*VN*FORUS*.pdf" $vans_forus
  }

  if (Test-Path -Path "./*JS*FORUS*.pdf" -PathType leaf) {
    Write-Host "Archiving JanSport Forus to $jansport_forus"
    Move-Item "*JS*FORUS*.pdf" $jansport_forus
  }
  
  if (Test-Path -Path "./*JS*SAVE COMERCIAL E IMPORTADORA LTDA*.pdf" -PathType leaf) {
    Write-Host "Archiving JS SAVE... to $jansport_save"
    Move-Item "./*JS*SAVE COMERCIAL E IMPORTADORA LTDA*.pdf" $jansport_save
  }

  if (Test-Path -Path "./*JS*SMASH TRADING*.pdf" -PathType leaf) {
    Write-Host "Moving SMASH TRADING to $invoices/SMASH TRADING"
    Move-Item "./*JS*SMASH TRADING*.pdf" "$invoices/SMASH TRADING"
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
    Write-Host "Moving TNF JUST US to $justus_edit"
    Move-Item "TNF*JUST*US*" $justus_edit
    folderme $justus_edit vans grimoldi
  }

}
