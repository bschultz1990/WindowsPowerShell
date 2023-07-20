function test {
  Write-Host "It worked!"
}

function trash {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
    [String[]]$files
  )
  Remove-ItemSafely $files
}

function fzo {
  Invoke-Item $(fzf)
}


function doctypes {
  clear
  Write-Host "=== Document Types ===`n"
  "4200 = Factory PO (not specific)`n" +
  "1001 = Sales Doc`n" +
  "501_ = External ID of Delivery Note`n" +
  "V000 = External ID of Delivery Note`n" +
  "352_ = Billing Document / Invoice (100% specific)`n"
}

function checklist {
  clear
  Write-Host "=== Invoice Checklist ===`n"
  "[ ] Run Python`n" +
  "[ ] NGC Numbers moved on all pages`n" +
  "[ ] Delete footers from middle pages`n" +
  "[ ] Page numbers correct`n" +
  "[ ] Total value`n" +
  "[ ] Total Qty/Pcs from official PL`n" +
  "[ ] Total Cartons/Pkg from official PL`n" +
  "[ ] Net Wt. from official PL`n" +
  "[ ] Gross wt. from BL or AWB`n" +
  "[ ] Add 'Confirmed BJS' to inovice file and send`n"
}

##FIXME
# function fzd {
#         $regex = ".*(?=\\)"
#         $dir = $regex$(fzf)
#           Write-Host $dir
#         }

function brands {
  Set-Clipboard "VANS; ALTRA; CORP_SERV; DICKIES; ICEBREAKER; JANSPORT; NORTHFACE; OA_CLEAR; OA_COAL; PANAMA; SMARTWOOL; SUPREME; TIMBERLAND; VANSCASA"
  Write-Host "Brands copied!"
}

function docs ($ngc) {
  $url = "https://vfc.sharepoint.com/sites/AppletonINLDocuments/_layouts/15/search.aspx/siteall?q=" + "$ngc"
  start $url
}

function rename ($file) {
  $destination = Read-Host "Enter a new name"
  Rename-Item -Path "$file" -NewName "$destination"
  # Set-Clipboard $destination
  # Write-Host "$destination copied!"
}

function cwd {
  Set-Clipboard (getdir)
}
# FIXME:
function zip { 
  param (
    [CmdletBinding()]
    [Parameter(Mandatory = $true, position = 0, ValueFromRemainingArguments = $true)]
    [String[]]$files
  )
  while (! $zipfile) {
    $zipfile = Read-Host "Enter folder name."
  }
  $files2 = $files.replace(" ", ",")
  Write-Host $files
  Write-Host $files2
  # Compress-Archive -Path "$files2" -DestinationPath ("$pwd" + "\" + "$zipfile" + ".zip")
}

function unzip ($file, $folder) {
  if (!$file) { $file = Read-Host "Enter zip file name" }
  if (!$folder) { $folder = Read-Host "Enter folder name" }

  Expand-Archive -Path "$file" -DestinationPath $pwd\$folder
  trash $file
  c $folder
}

function c ($dir) {
  cd $dir 
  ls
}

#Only display the last two directories in the prompt
function prompthelper {
  $short_dir = $pwd.Replace('Microsoft.PowerShell.Core\FileSystem::', '')
  return $short_dir
}

function Prompt {
  return "$pwd`r`n> "
}

function f {
  Set-Location "$(find . -type d | fzf)"
}

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

function gn {
  Set-Clipboard ((Get-Item -Path $pwd).Name)
  Write-Host "Name copied!"
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
#  Open command 
function open {
  param (
    [CmdletBinding()]
    [Parameter(Mandatory = $true, position = 0, ValueFromRemainingArguments = $true)]
    [String[]]$files
  )
  Invoke-Item $files
}

function mv($file, $destination) {
  Move-Item -Path $file -Destination $destination
}

function touch($file) {
  "" | Out-File $file -Encoding UTF8
}

function mkdir ($dir) {
  New-Item -Path "." -Name "$dir" -ItemType "directory"
}

function ga { git add . }
function gs { git status }
function gp { git push }
function strip ($file) {
  if (-not $file) { return "Please provide a file name." }
  pdftk $file cat output out.pdf
  rm $file
  Rename-Item -Path out.pdf -NewName $file
}

# function note ($note) {
#   while (-not $note) { $note = Read-Host "Note content" }
#   if (-not (Test-Path notes.txt)) { 
#     Add-Content -Path notes.txt -Value (Get-Date -Format MM/dd:), $note
#     return
#   }
#     (Get-Content -Path "notes.txt" -Raw) -replace '^', ((Get-Date -Format MM/dd:) + "`n" + ("$note`n`n")) | Set-Content -Path "notes.txt" -Encoding utf8
# }

function note ($note) {
  while (-not $note) { $note = Read-Host "Note content" }
  Add-Content -Path notes.txt -Value (Get-Date -Format MM/dd:), $note
}

function lss ($dir) {
  $results = Get-ChildItem *$dir* -recurse -Attributes Directory
  foreach ($match in $results) {
    Write-Host $match.FullName
  }
}