function fileme2 {
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

  function moveme2 ($path, $destination) {
    if (Test-Path -Path $path -PathType leaf) {
      Move-Item $path $destination -PassThru
    }
  }


}

$bpaths = @{
  "_abdulwahab"          = @{
    "search"  = "./*ABDULWAHAB*.pdf"
    "dest"    = "$invoices/Ali Abdulwahab Al Mutawa"
    "archive" = 0
  }
  "_vans_forus"          = @{
    "search"  = "./*VN*FORUS*.pdf"
    "dest"    = $vans_forus
    "archive" = 0
  }
  "_jansport_forus"      = @{
    "search"  = "./*JS*FORUS*.pdf"
    "dest"    = $jansport_forus
    "archive" = 1
  }
  "_jansport_save"       = @{
    "search"  = "./*JS*SAVE COMERCIAL E IMPORTADORA LTDA*.pdf"
    "dest"    = $jansport_save
    "archive" = 0
  }
  "_jansport_smash"      = @{
    "search"  = "./*JS*SMASH TRADING*.pdf"
    "dest"    = "$invoices/SMASH TRADING"
    "archive" = 0
  }
  "_tnf_komax_chile"     = @{
    "search"  = "./*KOMAX*SA *.pdf"
    "dest"    = $tnf_komax_chile
    "archive" = 1
  }
  "_tnf_komax_peru"      = @{
    "search"  = "./*KOMAX*PERU *.pdf"
    "dest"    = $tnf_komax_peru
    "archive" = 0
  }
  "_smartwool_lostarrow" = @{
    "search"  = "./SW*LOST ARROW*.pdf"
    "dest"    = $smartwool_lostarrow_edit
    "archive" = 0
  }
  "_smartwool_starlike"  = @{
    "search"  = "./*STARLIKE*.pdf"
    "dest"    = $smartwool_starlike_edit
    "archive" = 0
  }
  "_vans_grimuru"        = @{
    "search"   = "./*VN*GRIMURU*.pdf"
    "dest"     = $vans_grimuru_edit
    "archive"  = 0
    "folderme" = 1
    "fd1"      = "vans"
    "fd2"      = "grimuru"
  }
  "_tnf_importadora"     = @{
    "search"   = "./*TNF*IMPORTADORA*.pdf"
    "dest"     = $tnf_comercial_edit
    "archive"  = 0
    "folderme" = 1
    "fd1"      = "tnf"
    "fd2"      = "comercial"
  }
  "_vans_arezzo"         = @{
    "search"   = "./*VN*AREZZO*.pdf"
    "dest"     = $vans_arezzo_edit
    "archive"  = 0
    "folderme" = 1
    "fd1"      = "vans"
    "fd2"      = "arezzo"
  }
  "_tnf_justus"          = @{
    "search"   = "./TNF*JUST*US*"
    "dest"     = $justus_edit
    "archive"  = 0
    "folderme" = 1
    "fd1"      = "tnf"
    "fd2"      = "justus"
  }
  "_vans_grimoldi"       = @{
    "search"   = "./VN*GRIMOLDI*"
    "dest"     = $vans_grimoldi_edit
    "archive"  = 0
    "folderme" = 1
    "fd1"      = "vans"
    "fd2"      = "grimoldi"
  }
}
