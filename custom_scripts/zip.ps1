function zip { 
  param (
    [CmdletBinding()]
    [Parameter(Mandatory = $true, position = 0, ValueFromRemainingArguments = $true)]
    [String[]]$files
  )
  while (! $zipfile) {
    $zipfile = Read-Host "Enter folder name."
  }
  Compress-Archive -Path $files -DestinationPath ("$pwd" + "\" + "$zipfile" + ".zip")
}

function unzip ($file, $folder) {
  if (!$file) { $file = Read-Host "Enter zip file name" }
  if (!$folder) { $folder = Read-Host "Enter folder name" }

  Expand-Archive -Path "$file" -DestinationPath $pwd\$folder
  trash $file
  Clear-Host
  Set-Location $folder
  Get-ChildItem
}