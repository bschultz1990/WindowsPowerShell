function folderme {
  param (
    [string]$FolderPath,
  )
  if (-not ("$FolderPath")) {
    $FolderPath = "."
    }
  Write-Host "Processing in $FolderPath"

  $ext = "*.", "pdf" -join ""
  $files = Get-ChildItem -Path $FolderPath -Filter $ext -File

  $prefix = Read-Host "What is before your match?"
  $suffix = Read-Host "What is immediately after your match?"
  $regex = $prefix, "(.+?)", $suffix -join ""
  # Write-Host "regex is: $regex"

  $prename = Read-Host "What would you like before your new folder name? (leave blank to skip)"
  $postname = Read-Host "How about after? (leave blank to skip)"

  $uniqueMatches = @{}  # create hashtable to store unique matches

  foreach ($file in $files) {
    if ($file.Name -match "$regex") {
      $newFolderName = "$prename", $Matches[1], "$postname" -join ""
      $newFolderPath = Join-Path -Path $FolderPath -ChildPath $newFolderName

      # check if folder name already exists in hashtable
      if ($uniqueMatches.ContainsKey($newFolderName)) {
        $newFolderPath = $uniqueMatches[$newFolderName]  # use existing folder path
        } else {
          # create new folder and add to hashtable
          if (-not (Test-Path -Path $newFolderPath)) {
            New-Item -ItemType Directory -Path $newFolderPath | Out-Null
            Write-Host $newFolderPath
          }
          $uniqueMatches[$newFolderName] = $newFolderPath
        }

        Move-Item -Path $file.FullName -Destination $newFolderPath
      }
    }
  }
