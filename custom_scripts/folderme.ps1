function folderme {
  param (
    [string]$FolderPath,
    [string]$company,
    [string]$brand
  )
  if (-not ("$FolderPath")) {
    $FolderPath = "."
  }
  Write-Host "Processing in $FolderPath"
  if (-not ("$company")) {
    $company = Read-Host "Company"
  }
  if (-not ("$brand")) {
    $brand = Read-Host "Brand"
  }

  $company = $company.ToLower()
  $brand = $brand.ToLower()

  $tnf = @{
    comercial   = @{
      prefix = 'TNF '
      suffix = ' TNF COMERCIAL'
    }
    komax_chile = @{
      prefix = 'TNF '
      suffix = ' KOMAX SA'
    }
    komax_peru  = @{
      prefix = 'TNF'
      suffix = ' KOMAX PERU'
    }
    justus      = @{
      prefix = 'TNF'
      suffix = ' JUST US'
    }
    grimoldi    = @{
      prefix = 'TNF '
      suffix = ' GRIMOLDI'
    }
  }
  $smartwool = @{
    starlike = @{
      prefix = 'SW '
      suffix = ' STARLIKE'
    }
  }
  $vans = @{
    grimuru  = @{
      prefix = 'VN '
      suffix = ' GRIMURU'
    }
    forus    = @{
      prefix = 'VN '
      suffix = ' FORUS'
    }
    arezzo   = @{
      prefix = 'VN '
      suffix = ' AREZZO'
    }
    grimoldi = @{
      prefix = 'VN '
      suffix = ' GRIMOLDI'
    }
  }

  $files = Get-ChildItem -Path $FolderPath -Filter *.pdf -File
  $prefix = (Get-Variable -Name $company -ValueOnly).$brand.prefix
  $suffix = (Get-Variable -Name $company -ValueOnly).$brand.suffix
  $regex = $prefix, "(.+?)", $suffix -join ""
  # Write-Host "regex is: $regex"

  $uniqueMatches = @{}  # create hashtable to store unique matches

  foreach ($file in $files) {
    if ($file.Name -match "$regex") {
      $newFolderName = $Matches[1], "_NEW" -join ""
      $newFolderPath = Join-Path -Path $FolderPath -ChildPath $newFolderName

      # check if folder name already exists in hashtable
      if ($uniqueMatches.ContainsKey($newFolderName)) {
        $newFolderPath = $uniqueMatches[$newFolderName]  # use existing folder path
      }
      else {
        # create new folder and add to hashtable
        if (-not (Test-Path -Path $newFolderPath)) {
          New-Item -ItemType Directory -Path $newFolderPath | Out-Null
          Write-Host $newFolderName
        }
        $uniqueMatches[$newFolderName] = $newFolderPath
      }
      Move-Item -Path $file.FullName -Destination $newFolderPath
    }
  }
}
