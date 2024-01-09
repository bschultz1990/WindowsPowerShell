. $PSScriptRoot\vfpaths.ps1
function fileme {
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
        if (-not (Test-Path $bpaths.$key.dest)) {
          Write-Host $bpaths.$key.dest "does not exist. Creating..." -ForegroundColor Yellow -NoNewline
          New-Item -ItemType Directory -Path $bpaths.$key.dest
        }

        Move-Item $i $bpaths.$key.dest
        Write-Host $i.name -NoNewline -ForegroundColor DarkGray 
        Write-Host " Done!" -ForegroundColor Green
      }
        
      if ($bpaths.$key.action -eq "folder") {
        folderme $bpaths.$key.dest $bpaths.$key.fd1 $bpaths.$key.fd2
      }
    }

  }
}
Write-Host ""

$bpaths = @{
  "_altra_lotus"         = @{
    "search" = "./*ALT*LOTUS*.pdf"
    "dest"   = "$altra_lotus_2024"
    "action" = "archive"
  }
  "_abdulwahab"          = @{
    "search" = "./*ABDULWAHAB*.pdf"
    "dest"   = "$jansport_ali_abdulwahab"
    "action" = "archive"
  }
  "_vans_forus"          = @{
    "search" = "./*VN*FORUS*.pdf"
    "dest"   = $vans_forus_2024
    "action" = "archive"
  }
  "_jansport_forus"      = @{
    "search" = "./*JS*FORUS*.pdf"
    "dest"   = $jansport_forus_2024
    "action" = "archive"
  }
  "_jansport_save"       = @{
    "search" = "./*JS*SAVE COMERCIAL E IMPORTADORA LTDA*.pdf"
    "dest"   = $jansport_save_2024
    "action" = "archive"
  }
  "_jansport_smash"      = @{
    "search" = "./*JS*SMASH TRADING*.pdf"
    "dest"   = "$invoices/SMASH TRADING"
    "action" = "edit"
  }
  "_tnf_komax_chile"     = @{
    "search" = "./*KOMAX*SA *.pdf"
    "dest"   = $tnf_komax_chile_2024
    "action" = "archive"
  }
  "_tnf_komax_peru"      = @{
    "search" = "./*KOMAX*PERU *.pdf"
    "dest"   = $tnf_komax_peru_2024
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
    "dest"   = $tnf_justus_edit
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
