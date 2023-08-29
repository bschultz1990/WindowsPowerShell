function findme2 {
  param (
    [string]$file,
    [string]$folderflag
  )
  if (-not ("$file")) {
    return "Please provide a valid file and directory to search for."
  }

  $directory = "."

  # Assume we're finding folder names
  $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -Directory -recurse

  # ..unless the user omits the folder flag ;)
  if ($folderflag -eq "") {
    $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -File -recurse
  }

  if ($filematches.Count -gt 0) {
    $results = @()
    Write-Host "Partial matches found:"
    foreach ($match in $filematches) {
      $results += $match.FullName
    }
    for ($i = 0; $i -lt $results.Length; $i++) {
      Write-Host "$i $($results[$i])"
    }
    [int]$index = Read-Host "select"
    $global:find_selection = $results[$index]
    Set-Clipboard $results[$index]
    return 1
  }
  return 0
}
function findme {
  param (
    [string]$file,
    [string]$directory
  )
  if (-not (Test-Path "$directory") -or -not ("$file")) {
    return "Please provide a valid file and directory to search for."
  }
  $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -File
  if ($filematches.Count -gt 0) {
    Write-Host "Partial matches found:"
    foreach ($match in $filematches) {
      Write-Host $match.FullName
    }
    return 1
  }
  return 0
}

