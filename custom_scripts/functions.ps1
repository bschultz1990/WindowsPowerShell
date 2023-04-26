#Only display the last two directories in the prompt
function Prompt {
  "$(getdir)`r`n> "
  # "$(Split-Path -Path (Get-Location) -Leaf)`r`n> "
}

function findme2 {
  param (
    [string]$file,
    [string]$directory,
    [string]$folder
  )
  if (-not (Test-Path "$directory") -or -not ("$file")) {
    return "Please provide a valid file and directory to search for."
  }
  if ($folder = 1) {
    $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -Directory
  }
  else {
    $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -File
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

function getdir {
  Set-Clipboard $pwd
  $full_path = Get-Clipboard
  $prefix = "Microsoft.PowerShell.Core\FileSystem::"
  return $full_path.Replace($prefix, "")
}

function getpath($file) {
  if (!$file) {
    Write-Host "Error: No source file provided."
    return
  }
  $dir = (Get-Item $file).DirectoryName
  $file = (Get-Item $file).Name
  $path = Join-Path $dir $file
  Set-Clipboard $path
  Write-Host "Copied $path to clipboard"
}

function man($cmd) {
  Get-Help $cmd -full
}

function open ($file) {
  Invoke-Item $file
}

function mv($file, $destination) {
  Move-Item -Path $file -Destination $destination
}

function touch($file) {
  "" | Out-File $file -Encoding ASCII
}

function mkdir ($dir) {
  New-Item -ItemType Directory -Path $dir -Force
}

function trash ($file) {
  Move-Item -Path $file -Destination $trash_folder -Force
}

function trashempty {
  Remove-Item -Path $trash_folder\*
  Write-Host "Trash emptied."
}

function trashview {
  $back = $PWD
  cd $trash_folder
  ls
}