function fzo {
  Invoke-Item $(fzf)
}

##FIXME
# function fzd {
#         $regex = ".*(?=\\)"
#         $dir = $regex$(fzf)
#           Write-Host $dir
#         }

function reinvoice ($files) {
        mv $files ~/Downloads
        python $invscript_local
        mv ~/Downloads/* .
}

function dc ($ngc) {
        $url1 = "https://vfc.sharepoint.com/sites/AppletonINLDocuments/_layouts/15/search.aspx/siteall?q=","$ngc", -join ""
        Write-Host $url
}

function rename ($file) {
  # Set-Clipboard $file
  $destination = Read-Host "Enter a new name:"
    Rename-Item -Path "$file" -NewName "$destination"
}

function cwd {
  Set-Clipboard (getdir)
}

function combine($file1, $file2) {
  $out_dir = getdir
  $name = Read-Host "Output file name?"
  $file1, $file2 | Merge-PDF -OutputPath $out_dir\$name.pdf -Force
  # open $out_dir\$name.pdf
}
#
# function combine() {
# [CmdletBinding()]
#     param (
#         [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
#         [String[]]$Files
#     )
#   $out_dir = getdir
#   $name = Read-Host "Output file name?"
#   $Files | Merge-PDF -OutputPath $out_dir\$name.pdf
#   open $out_dir\$name.pdf
# }

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

