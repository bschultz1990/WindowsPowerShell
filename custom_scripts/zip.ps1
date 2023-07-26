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

