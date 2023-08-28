function zip ($files, $zipfile) { 
  while (!$files) { $files = Read-Host "Enter files to unzip" }
  while (!$zipfile) { $zipfile = Read-Host "Enter folder name" }
  Compress-Archive -Path $files -DestinationPath ("$pwd" + "\" + "$zipfile" + ".zip")
}

function unzip ($file, $folder) {
  while (!$file) { $file = Read-Host "Enter a file to unzip" }
  while (!$folder) { $folder = Read-Host "Enter a folder to unzip into" }

  Expand-Archive -Path "$file" -DestinationPath $pwd\$folder
  Remove-Item $file
  Clear-Host
  Set-Location $folder
  Get-ChildItem
}
