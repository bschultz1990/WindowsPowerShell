function fzo {
  Invoke-Item $(fzf)
}

##FIXME
# function fzd {
#         $regex = ".*(?=\\)"
#         $dir = $regex$(fzf)
#           Write-Host $dir
#         }

function rename ($file) {
  $destination = Read-Host "Enter a new name:"
    Rename-Item -Path "$file" -NewName "$destination"
}

function cwd {
  Set-Clipboard (getdir)
}

function unzip ($file, $folder) {
  if (!$file){ $file = Read-Host "Enter zip file name" }
  if (!$folder){ $folder = Read-Host "Enter folder name" }

  Expand-Archive -Path "$file" -DestinationPath $pwd\$folder
    trash $file
    c $folder
}

function c ($dir) {
  cd $dir 
    ls
}

function reload {
  . "$profile"
}

#Only display the last two directories in the prompt
function Prompt {
  return "$pwd`r`n> "
}

function f {
  Set-Location "$(find . -type d | fzf)"
}

function findme2 {
  param (
      [string]$file,
      [string]$directory,
      [string]$folderflag
      )
    if (-not (Test-Path "$directory") -or -not ("$file")) {
      return "Please provide a valid file and directory to search for."
    }

  # Assume we're finding folder names
  $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -Directory

  # ..unless the user omits the folder flag ;)
  if (! $folderflag) {
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
  New-Item -Path "." -Name "$dir" -ItemType "directory"
}

