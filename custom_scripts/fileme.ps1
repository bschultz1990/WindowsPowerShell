. $PSScriptRoot\vfpaths.ps1
function fileme {
  $confirmed = $false
  while ($confirmed -eq $false) {
    Write-Host "=== IMPORTANT! Complete all of the following before continuing:===" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "[ ] Remove all Starlike orders that are USDC" -ForegroundColor DarkGray
    
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
  
  # if the backup directory doesn't exist, create one.
  if (-not (Test-Path backup)) {
    $null = mkdir backup
  }
  Copy-Item *.pdf "./backup"
  
  foreach ($key in $bpaths.Keys) {
    if (Test-Path -Path $bpaths.$key.search -PathType leaf) {
      Write-Host ""
      Write-Host "Moving to" $bpaths.$key.dest
      
      foreach ($i in (Get-ChildItem $bpaths.$key.search)) {
        # if (-not (Test-Path -Path $bpaths.$key.dest)) {
        #   Write-Host $bpaths.$key.dest "does not exist. Creating..." -ForegroundColor Yellow -NoNewline
        #   mkdir $bpaths.$key.dest
        # }
        Move-Item $i $bpaths.$key.dest -ErrorAction SilentlyContinue -ErrorVariable err
        Write-Host $i.name -NoNewline -ForegroundColor DarkGray 
      }
        
      if ($err) {
        Write-Host " already exists." -ForegroundColor Yellow
      }

      if (-not $err) {
        Write-Host " Done!" -ForegroundColor Green
      }

      $err = $null

    }
    if ($bpaths.$key.action -eq "folder") {
      folderme $bpaths.$key.dest $bpaths.$key.fd1 $bpaths.$key.fd2
    }

  }
}
Write-Host ""

$bpaths = @{
  "_altra_lotus"         = @{
    "search" = "./*ALT*LOTUS*.pdf"
    "dest"   = "$altra_lotus"
    "action" = "archive"
  }
  "_abdulwahab"          = @{
    "search" = "./*ABDULWAHAB*.pdf"
    "dest"   = "$jansport_ali_abdulwahab"
    "action" = "archive"
  }
  "_vans_forus"          = @{
    "search" = "./*VN*FORUS*.pdf"
    "dest"   = $vans_forus
    "action" = "archive"
  }
  "_jansport_forus"      = @{
    "search" = "./*JS*FORUS*.pdf"
    "dest"   = $jansport_forus
    "action" = "archive"
  }
  "_jansport_save"       = @{
    "search" = "./*JS*SAVE COMERCIAL E IMPORTADORA LTDA*.pdf"
    "dest"   = $jansport_save
    "action" = "archive"
  }
  "_jansport_smash"      = @{
    "search" = "./*JS*SMASH TRADING*.pdf"
    "dest"   = "$invoices/SMASH TRADING"
    "action" = "edit"
  }
  "_tnf_komax_chile"     = @{
    "search" = "./*KOMAX*SA *.pdf"
    "dest"   = $tnf_komax_chile
    "action" = "archive"
  }
  "_tnf_komax_peru"      = @{
    "search" = "./*KOMAX*PERU *.pdf"
    "dest"   = $tnf_komax_peru
    "action" = "archive"
  }
  "_smartwool_lostarrow" = @{
    "search" = "./SW*LOST ARROW*.pdf"
    "dest"   = $smartwool_lostarrow_edit
    "action" = "edit"
  }
  "_smartwool_starlike"  = @{
    "search" = "./*STARLIKE*.pdf"
    "dest"   = $smartwool_starlike_edit
    "action" = "edit"
  }
  "_vans_grimuru"        = @{
    "search" = "./*VN*GRIMURU*.pdf"
    "dest"   = $vans_grimuru_edit
    "action" = "folder"
    "fd1"    = "vans"
    "fd2"    = "grimuru"
  }
  "_tnf_importadora"     = @{
    "search" = "./*TNF*IMPORTADORA*.pdf"
    "dest"   = $tnf_comercial_edit
    "action" = "folder"
    "fd1"    = "tnf"
    "fd2"    = "comercial"
  }
  "_vans_arezzo"         = @{
    "search" = "./*VN*AREZZO*.pdf"
    "dest"   = $vans_arezzo_edit
    "action" = "folder"
    "fd1"    = "vans"
    "fd2"    = "arezzo"
  }
  "_tnf_justus"          = @{
    "search" = "./TNF*JUST*US*"
    "dest"   = $justus_edit
    "action" = "folder"
    "fd1"    = "tnf"
    "fd2"    = "justus"
  }
  "_vans_grimoldi"       = @{
    "search" = "./VN*GRIMOLDI*"
    "dest"   = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMOLDI"
    "action" = "folder"
    "fd1"    = "vans"
    "fd2"    = "grimoldi"
  }
  "_tnf_grimoldi"        = @{
    "search" = "./TNF*GRIMOLDI*"
    "dest"   = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMOLDI"
    "action" = "folder"
    "fd1"    = "tnf"
    "fd2"    = "grimoldi"
  }
}