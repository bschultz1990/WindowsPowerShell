function pl {
  param (
    [Parameter(Mandatory = $true)]
    [string]$ngc
  )
  if (-not (Test-Path backup)) {
    New-Item -Path . -Name "backup" -ItemType "directory" | Out-Null 
  }

  if (-not (Test-Path pl.pdf)) {
    Write-Host "pl.pdf not found. Trying to move from downloads..."
    try {
      Move-Item -Path "$dl\pl.pdf" -Destination ".\"
    }
    catch {
      Write-Host "An error occurred while trying to move pl.pdf from Downloads: $_"
      return
    }
  }

  if (-not (Test-Path $stamp_vans_pl)) {
    Write-Host "Stamp missing. Please provide the following stamp here:"
    Write-Host "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Vans_PL.pdf"
    return
  }

  if (-not (Get-Command "cpdf" -errorAction SilentlyContinue)) {
    Write-Host "cpdf application not found. Please install it here to proceed:"
    Write-Host "C:\Users\bschul3\Apps\cpdf.EXE"
    return
  }

  cpdf -stamp-on $stamp_vans_pl pl.pdf 1 -o "PL_$ngc.pdf"
  Move-Item pl.pdf backup
  Invoke-Item "PL_$ngc.pdf"
}